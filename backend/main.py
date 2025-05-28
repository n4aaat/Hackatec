import os
import io
import json
import base64

from fastapi import FastAPI, UploadFile, File
from pydantic import BaseModel
from openai import OpenAI
from PIL import Image
import torch
import torchvision.transforms as T
from torchvision.models import densenet121
from captum.attr import IntegratedGradients
from dotenv import load_dotenv

# ——— Configuración ———
load_dotenv()  # carga .env en el directorio actual
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
client = OpenAI(api_key=OPENAI_API_KEY)

# ——— Base de conocimiento ———
KB = json.load(open("kb.json", encoding="utf-8"))

# ——— Modelo de visión entrenado ———
device = "cuda" if torch.cuda.is_available() else "cpu"

# Carga DenseNet-121 y reemplaza la cabeza con tu head fine-tuneado
model = densenet121(weights=None)
model.classifier = torch.nn.Linear(model.classifier.in_features, 2)
model.load_state_dict(torch.load("models/chexnet_head.pt", map_location=device))
model = model.to(device).eval()

# ——— Transforms para imagen ———
preprocess = T.Compose([
    T.Resize((512, 512)),
    T.ToTensor(),
    T.Normalize([0.485, 0.456, 0.406],
                [0.229, 0.224, 0.225])
])

# ——— Helpers ———
def find_steps(text: str) -> str:
    t = text.lower()
    for entry in KB.values():
        if any(kw in t for kw in entry["keywords"]):
            return "\n".join(entry["steps"])
    return ""

CHAT_PROMPT = """Eres AuxilIA, un asistente de primeros auxilios NO profesional.
- Sólo ofreces hasta 5 pasos numerados.
- Si la situación puede ser grave, indicas: "Busca atención médica inmediata o llama al 911".
{steps_block}
Usuario: {msg}
AuxilIA:"""

# ——— FastAPI App ———
app = FastAPI(title="AuxilIA API", version="0.1.0")

class ChatRequest(BaseModel):
    user: str
    message: str

@app.post("/chat")
async def chat_endpoint(body: ChatRequest):
    steps = find_steps(body.message)
    steps_block = f"Pasos sugeridos:\n{steps}" if steps else ""
    prompt = CHAT_PROMPT.format(steps_block=steps_block, msg=body.message)
    resp = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": prompt}],
        max_tokens=150,
        temperature=0.2
    )
    reply = resp.choices[0].message.content.strip()
    return {"reply": reply}

@app.post("/predict_image")
async def predict_image_endpoint(img: UploadFile = File(...)):
    # Leer imagen
    data = await img.read()
    pil = Image.open(io.BytesIO(data)).convert("RGB")

    # Preprocesar e inferir
    x = preprocess(pil).unsqueeze(0).to(device)
    logits = model(x)
    prob = float(torch.softmax(logits, dim=1)[0, 1])

    # Captum heatmap
    ig = IntegratedGradients(model)
    attr = ig.attribute(x, target=1).abs().sum(1)[0]
    heat = T.ToPILImage()(attr / attr.max())
    heat = heat.resize(pil.size).convert("RGBA")
    heat.putalpha(100)
    overlay = Image.alpha_composite(pil.convert("RGBA"), heat)

    # Devuelve base64
    buf = io.BytesIO()
    overlay.save(buf, format="PNG")
    b64 = base64.b64encode(buf.getvalue()).decode()

    return {"probability": round(prob, 3), "heatmap": b64}
