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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hello there!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "How can I help you today?",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              // Aquí no mostramos mensajes, solo un espacio vacío
              Expanded(child: Container()),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: Icon(_listening ? Icons.mic : Icons.mic_none),
                    onPressed: _toggleListening,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Send a message...',
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_controller.text),
                  ),
                  IconButton(
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
