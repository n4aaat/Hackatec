import 'package:auxilia_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5CCC8),
      drawer: const CustomNavBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 102, 146, 111),
        automaticallyImplyLeading:
            false, // Oculta el botón de retroceso (si no es necesario)
        title: Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Alinea a la derecha
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centra verticalmente
            children: [
              Image.asset(
                'assets/imagenes/logohorizontal.png',
                height:
                    50, // Reduje la altura para que quepa mejor en el AppBar
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Para evitar overflow en pantallas pequeñas
          child: Container(
            width: 380,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFF1E627C),
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
                _buildInputField('Correo electrónico', icon: Icons.email),
                const SizedBox(height: 20),
                _buildInputField('Contraseña',
                    isPassword: true, icon: Icons.lock),
                const SizedBox(height: 30),
                _buildLoginButton(context),
                const SizedBox(height: 16),
                _buildTextButton('Recuperar contraseña', onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.recuperaPass);
                }),
                _buildTextButton('Crear cuenta', onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.register);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label,
      {bool isPassword = false, IconData? icon}) {
    return TextFormField(
      // Cambiado a TextFormField para mejor manejo
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navegar al home después del login
          Navigator.pushReplacementNamed(context, AppRoutes.register);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF72C7D3),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Ingresar',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18, // Tamaño aumentado
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, {required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFFBFE3D5),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
