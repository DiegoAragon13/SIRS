import 'package:flutter/material.dart';
import '../../widgets/CustomBottomNavigation.dart';
import '../../widgets/CustomHeader.dart';
import '../../widgets/CustomDrawer.dart';
import '../../widgets/FeaturedStudentsCard.dart';
import '../../widgets/GestionVacantesScreen.dart';
import '../../widgets/QuickActionsCard.dart';
import '../../widgets/StatsGrid.dart';
import '../../widgets/WelcomeSection.dart';

class PortalEmpresaScreen extends StatefulWidget {
  const PortalEmpresaScreen({Key? key}) : super(key: key);

  @override
  State<PortalEmpresaScreen> createState() => _PortalEmpresaScreenState();
}

class _PortalEmpresaScreenState extends State<PortalEmpresaScreen> {
  int _drawerSelectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _syncNavigation(int index) {
    setState(() {
      _drawerSelectedIndex = index;
    });

    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(_scaffoldKey.currentContext!);
    }

    _navigateToSection(index);
  }

  void _navigateToSection(int index) {
    // Si ya estamos en GestionVacantesScreen y queremos volver al Resumen
    if (ModalRoute.of(context)?.settings.name == '/gestion-vacantes' && index == 0) {
      Navigator.pop(context);
      return;
    }

    switch (index) {
      case 0: // Resumen
      // Ya estamos en la pantalla principal
        break;
      case 1: // Vacantes
        _navigateToGestionVacantes();
        break;
      case 2: // Estudiantes
        _showComingSoonMessage('Estudiantes');
        break;
      case 3: // Solicitudes
        _showComingSoonMessage('Solicitudes');
        break;
    }
  }

  void _showComingSoonMessage(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$section - Próximamente'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToGestionVacantes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GestionVacantesScreen(),
        settings: const RouteSettings(name: '/gestion-vacantes'),
      ),
    );
  }

  void _onQuickActionPressed(String action) {
    switch (action) {
      case 'crear_vacante':
        _navigateToGestionVacantes();
        break;
      case 'ver_vacantes':
        _navigateToGestionVacantes();
        break;
    }
  }

  void _onLogout() {
    // Implementar lógica de logout
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí iría la lógica real de logout
            },
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  void _onNotificationTap() {
    _showComingSoonMessage('Notificaciones');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: CustomDrawer(
        selectedIndex: _drawerSelectedIndex,
        onItemSelected: _syncNavigation,
      ),
      body: Column(
        children: [
          CustomHeader(
            userAvatar: 'CR',
            userName: 'Carlos Ruiz',
            onLogout: _onLogout,
            onNotificationTap: _onNotificationTap,
            onMenuTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            showDrawerButton: true,
            showUserInfo: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const WelcomeSection(),
                  const SizedBox(height: 20),
                  const StatsGrid(),
                  const SizedBox(height: 20),
                  QuickActionsCard(
                    onActionPressed: _onQuickActionPressed,
                  ),
                  const SizedBox(height: 20),
                  const FeaturedStudentsCard(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _drawerSelectedIndex,
        onTabSelected: _syncNavigation,
      ),
    );
  }
}