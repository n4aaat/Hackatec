import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5CCC8), // Fondo suave
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF1E627C), // Fondo caja login
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(5, 5),
                blurRadius: 15,
              ),
              BoxShadow(
                color: Colors.white24,
                offset: Offset(-3, -3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'INICIAR SESIÓN',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBFE3D5),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _buildInputField('Correo electrónico'),
              const SizedBox(height: 20),
              _buildInputField('Contraseña', isPassword: true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción de login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72C7D3),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black45,
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Acción recuperar contraseña
                },
                child: const Text(
                  'Recuperar contraseña',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFBFE3D5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Acción crear cuenta
                },
                child: const Text(
                  'Crear cuenta',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFBFE3D5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF72C7D3), width: 2),
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
