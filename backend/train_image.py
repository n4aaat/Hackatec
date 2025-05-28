import os
import torch
from torch import nn, optim
from torch.utils.data import DataLoader
import torchvision.transforms as T
import torchvision.datasets as D
from torchvision.models import densenet121
import argparse

def get_loaders(data_dir, batch_size=16):
    tfm = T.Compose([
        T.Resize((512,512)),
        T.RandomHorizontalFlip(),
        T.ToTensor(),
        T.Normalize([0.485,0.456,0.406],[0.229,0.224,0.225])
    ])
    train_ds = D.ImageFolder(os.path.join(data_dir,'train'), transform=tfm)
    val_ds   = D.ImageFolder(os.path.join(data_dir,'val'),   transform=tfm)
    return DataLoader(train_ds, batch_size=batch_size, shuffle=True, num_workers=4), \
           DataLoader(val_ds,   batch_size=batch_size, shuffle=False, num_workers=4)

def train(args):
    device = 'cuda' if torch.cuda.is_available() else 'cpu'

    # Modelo pre-entrenado
    model = densenet121(weights="IMAGENET1K_V1")
    # Reemplaza solo la cabeza
    model.classifier = nn.Linear(model.classifier.in_features, 2)
    # Congela los demás parámetros
    for p in model.features.parameters():
        p.requires_grad = False
    model = model.to(device)

    train_loader, val_loader = get_loaders(args.data_dir, args.batch_size)
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.classifier.parameters(), lr=args.lr)

    best_acc = 0.0
    for epoch in range(args.epochs):
        model.train()
        total, correct = 0, 0
        for x,y in train_loader:
            x,y = x.to(device), y.to(device)
            optimizer.zero_grad()
            out = model(x)
            loss = criterion(out,y)
            loss.backward()
            optimizer.step()
            preds = out.argmax(dim=1)
            total += y.size(0)
            correct += (preds == y).sum().item()
        train_acc = correct/total
        print(f"Epoch {epoch+1}/{args.epochs} — Train Acc: {train_acc:.3f}")

        # Validación
        model.eval()
        total, correct = 0, 0
        with torch.no_grad():
            for x,y in val_loader:
                x,y = x.to(device), y.to(device)
                out = model(x)
                preds = out.argmax(dim=1)
                total += y.size(0)
                correct += (preds == y).sum().item()
        val_acc = correct/total
        print(f"           Val   Acc: {val_acc:.3f}")
        # Guarda mejor modelo
        if val_acc > best_acc:
            best_acc = val_acc
            torch.save(model.state_dict(), args.save_path)
            print(f"  ✔ Modelo guardado con val_acc={best_acc:.3f}")

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("--data_dir",   default="data", help="Carpeta con train/ val/")
    p.add_argument("--epochs",     type=int, default=3)
    p.add_argument("--batch_size", type=int, default=16)
    p.add_argument("--lr",         type=float, default=3e-4)
    p.add_argument("--save_path",  default="models/chexnet_head.pt")
    args = p.parse_args()
    os.makedirs(os.path.dirname(args.save_path), exist_ok=True)
    train(args)
