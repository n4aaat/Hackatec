import 'package:flutter/material.dart';
import '../components/navbar.dart';

class SeguimientoPage extends StatefulWidget {
  const SeguimientoPage({Key? key}) : super(key: key);

  @override
  _SeguimientoPageState createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  bool _listening = false;
  final TextEditingController _messageController = TextEditingController();

  void _toggleListening() {
    setState(() {
      _listening = !_listening;
    });
  }

  void _sendSOS() {
    // Lógica para enviar alerta de emergencia
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alerta de emergencia'),
        content: const Text('Se ha enviado tu ubicación a los contactos de emergencia'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _openCamera() {
    // Lógica para abrir la cámara
    print('Abrir cámara');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const CustomNavBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 102, 146, 111),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/imagenes/logohorizontal.png',
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              '¿En qué puedo ayudarte?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3C6043),
              ),
            ),
            const SizedBox(height: 30),
            
            // Campo de texto mejorado
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Describe tu situación...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF72C7D3)),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      print('Mensaje enviado: ${_messageController.text}');
                      _messageController.clear();
                    }
                  },
                ),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 30),
            
            // Botón para subir foto (con efecto de pulsación)
            GestureDetector(
              onTap: () => _openCamera(),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF72C7D3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 50,
                      color: Color(0xFF72C7D3),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'SUBE TU FOTO\nA ANALIZAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const Spacer(),
            
            // Barra de acciones inferior con mejor diseño
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: _listening ? Icons.mic_off : Icons.mic,
                    color: _listening ? Colors.red : const Color(0xFF3C6043),
                    onPressed: _toggleListening,
                    label: _listening ? 'Detener' : 'Grabar',
                  ),
                  _buildActionButton(
                    icon: Icons.camera_alt,
                    color: const Color(0xFF3C6043),
                    onPressed: _openCamera,
                    label: 'Cámara',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 28),
          color: color,
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}