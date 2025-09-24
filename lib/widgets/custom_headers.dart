import 'package:flutter/material.dart';
import '../utils/themes/themes.dart';

class CustomAppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String userAvatar;
  final String? userName;
  final VoidCallback? onLogout;
  final VoidCallback? onNotificationTap;
  final bool showDrawerButton;
  final bool showUserInfo;

  const CustomAppHeader({
    Key? key,
    required this.title,
    this.subtitle,
    required this.userAvatar,
    this.userName,
    this.onLogout,
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
              
              // Botón de cerrar sesión
              if (onLogout != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onLogout,
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
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
            
            // Botón de cerrar sesión
            if (onLogout != null)
              GestureDetector(
                onTap: onLogout,
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}