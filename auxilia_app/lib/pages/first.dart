import 'package:flutter/material.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final TextEditingController _controller = TextEditingController();
  bool _listening = false;

  void _toggleListening() {
    setState(() {
      _listening = !_listening;
    });
    // Aquí puedes añadir lógica real si quieres
  }

  void _sendSOS() {
    // Acción SOS sencilla, puedes implementar geolocalización luego
    print('SOS pressed');
  }

  void _handleSubmitted(String text) {
    // Por ahora, solo limpia el campo
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],  // Fondo gris claro para mejor contraste
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),  // Más espacio para el contenido
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Alinear a la izquierda
            children: [
              const Text(
                "Hello there!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "How can I help you today?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  // Aquí puedes agregar mensajes o contenido futuro
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: Icon(
                      _listening ? Icons.mic : Icons.mic_none,
                      color: _listening ? Colors.red : Colors.black54,
                    ),
                    onPressed: _toggleListening,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Send a message...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    iconSize: 28,
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () => _handleSubmitted(_controller.text),
                  ),
                  IconButton(
                    iconSize: 28,
                    icon: const Icon(Icons.warning, color: Colors.red),
                    onPressed: _sendSOS,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
