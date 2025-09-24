import 'package:flutter/material.dart';
import '../Pages/login_screen.dart';

class CustomAppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String userAvatar;
  final String? userName;
  final VoidCallback? onNotificationTap;
  final bool showDrawerButton;
  final bool showUserInfo;

  const CustomAppHeader({
    Key? key,
    required this.title,
    this.subtitle,
    required this.userAvatar,
    this.userName,
    this.onNotificationTap,
    this.showDrawerButton = true,
    this.showUserInfo = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determinar si es móvil o desktop
    bool isMobile = MediaQuery.of(context).size.width < 1024;

    return isMobile ? _buildMobileHeader(context) : _buildDesktopHeader(context);
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary, // Using theme primary color
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Menú hamburguesa (solo si se requiere)
              if (showDrawerButton)
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              if (showDrawerButton) const SizedBox(width: 12),

              // Título y subtítulo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),

              // Notificaciones
              GestureDetector(
                onTap: onNotificationTap ?? () {},
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Avatar del usuario
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    userAvatar,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Botón de logout eliminado - ahora va en el drawer
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            // Logo ITD
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'ITD',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Título y descripción
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),

            // Notificaciones
            GestureDetector(
              onTap: onNotificationTap ?? () {},
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            // Info del usuario (solo en desktop si se requiere)
            if (showUserInfo && userName != null) ...[
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        userAvatar,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    userName!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
            ],

            // Botón de logout eliminado - ahora va en el drawer
          ],
        ),
      ),
    );
  }
}

// Modelo para items de navegación
class NavigationItem {
  final String id;
  final String label;
  final IconData icon;

  NavigationItem({
    required this.id,
    required this.label,
    required this.icon,
  });
}

// Utilidad para crear items de navegación del dashboard
class DashboardNavigationHelper {
  static List<NavigationItem> getDefaultNavigationItems() {
    return [
      NavigationItem(
        id: "overview",
        label: "Panel General",
        icon: Icons.dashboard,
      ),
      NavigationItem(
        id: "students",
        label: "Estudiantes",
        icon: Icons.school,
      ),
      NavigationItem(
        id: "documents",
        label: "Documentos",
        icon: Icons.description,
      ),
      NavigationItem(
        id: "companies",
        label: "Empresas",
        icon: Icons.business,
      ),
    ];
  }
}

// Widget de drawer/menú lateral retráctil reutilizable con estilo ORIGINAL
class CustomDrawer extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<NavigationItem> navigationItems;
  final String activeView;
  final Function(String) onItemTap;
  final VoidCallback? onLogout;
  final bool enableFirebaseLogout;

  const CustomDrawer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.navigationItems,
    required this.activeView,
    required this.onItemTap,
    this.onLogout,
    this.enableFirebaseLogout = false,
  }) : super(key: key);

  // Función de logout integrada y reutilizable
  void _handleLogout(BuildContext context) {
    // Si hay una función personalizada, usarla
    if (onLogout != null) {
      onLogout!();
      return;
    }

    // Logout por defecto: regresar a login screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF660B05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'ITD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Items de navegación (ESTILO ORIGINAL)
            ...navigationItems.map((item) {
              final isActive = activeView == item.id;
              return GestureDetector(
                onTap: () {
                  onItemTap(item.id);
                  Navigator.of(context).pop(); // Cerrar drawer
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF660B05)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isActive
                              ? Colors.white
                              : const Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const Spacer(), // Para empujar el botón hacia abajo

            // Botón de CERRAR SESIÓN con estilo original
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Cerrar drawer primero
                  Navigator.of(context).pop();
                  // Ejecutar logout
                  _handleLogout(context);
                },
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF660B05),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget de navegación inferior RESPONSIVE que cubre toda la parte de abajo
class CustomBottomNavigation extends StatelessWidget {
  final List<NavigationItem> navigationItems;
  final String activeView;
  final Function(String) onItemTap;

  const CustomBottomNavigation({
    Key? key,
    required this.navigationItems,
    required this.activeView,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 70, // Altura óptima
          child: Row(
            children: navigationItems.map((item) {
              final isActive = activeView == item.id;
              return Expanded( // ¡CADA BOTÓN OCUPA EL MISMO ESPACIO PARA CUBRIR TODO!
                child: GestureDetector(
                  onTap: () => onItemTap(item.id),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF660B05).withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF660B05)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item.icon,
                            size: 24,
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item.label.split(' ')[0], // Primera palabra
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFF660B05)
                                  : const Color(0xFF6B7280),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}