import 'package:flutter/material.dart';
import '../routes/app_routes.dart'; // Asegúrate de que la ruta sea correcta

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Encabezado con logo o nombre de la app
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF72C7D3), // Usa el color de tu tema
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AuxilIA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Menú principal',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Ítems del menú
          _NavItem(
            icon: Icons.search,
            title: 'Search',
            onTap: () => Navigator.pushNamed(context, AppRoutes.prueba), // Ajusta la ruta
          ),
          _NavItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Navigator.pushNamed(context, AppRoutes.prueba),
          ),
          _NavItem(
            icon: Icons.assignment,
            title: 'Projects',
            onTap: () => Navigator.pushNamed(context, AppRoutes.prueba),
          ),
          _NavItem(
            icon: Icons.analytics,
            title: 'Reports',
            onTap: () => Navigator.pushNamed(context, AppRoutes.prueba),
          ),
          // Agrega más ítems según necesites
          const Divider(),
          _NavItem(
            icon: Icons.settings,
            title: 'Configuración',
            onTap: () => Navigator.pushNamed(context, AppRoutes.prueba),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para los ítems del menú
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}