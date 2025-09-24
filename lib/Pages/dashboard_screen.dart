import 'package:flutter/material.dart';
import '../Pages/login_screen.dart';
import 'package:sirs/Pages/servicioalumno.dart';
import '../widgets/buttombarpato.dart';
import '../widgets/progress_widget.dart';
import '../widgets/recent_activity_widget.dart';
import '../widgets/upcoming_tasks_widget.dart';
import '../widgets/notifications_widget.dart';
import 'package:sirs/widgets/custom_headers.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _activeView = "overview";
  int _selectedBottomIndex = 0;
  final List<NavigationItem> _navigationItems = DashboardNavigationHelper.getDefaultNavigationItems();

  // Método para cambiar entre las diferentes vistas del bottom navigation
  Widget _buildCurrentView() {
    switch (_selectedBottomIndex) {
      case 0: // Home
        return _buildHomeView();
      case 1: // Servicio
        return _buildServicioView();
      case 2: // Residencia
        return _buildResidenciaView();
      default:
        return _buildHomeView();
    }
  }

  // Vista principal (Home/Dashboard)
  Widget _buildHomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ProgressWidget(),
          const SizedBox(height: 24),
          RecentActivityWidget(),
          const SizedBox(height: 24),
          UpcomingTasksWidget(),
          const SizedBox(height: 24),
          NotificationsWidget(),
          const SizedBox(height: 100), // Espacio para que no tape el bottom nav
        ],
      ),
    );
  }

  // Vista de Servicio - AHORA USA TU PÁGINA REAL
  Widget _buildServicioView() {
    return const ServicioAlumnoPage();
  }

  // Vista de Residencia
  Widget _buildResidenciaView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.holiday_village,
            size: 80,
            color: Color(0xFF8B4513),
          ),
          SizedBox(height: 16),
          Text(
            'Módulo de Residencia',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B4513),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Aquí irá el contenido de residencia',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Método para obtener el título según la vista activa
  String _getCurrentTitle() {
    switch (_selectedBottomIndex) {
      case 0:
        return "Dashboard";
      case 1:
        return "Servicio Social";
      case 2:
        return "Residencia";
      default:
        return "Dashboard";
    }
  }

  // Método para obtener el subtítulo según la vista activa
  String _getCurrentSubtitle() {
    switch (_selectedBottomIndex) {
      case 0:
        return "Resumen de tu progreso";
      case 1:
        return "Gestiona tu servicio social";
      case 2:
        return "Gestión de residencias";
      default:
        return "Resumen de tu progreso";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        title: "Usuario",
        subtitle: "Administrador",
        navigationItems: _navigationItems,
        activeView: _activeView,
        onItemTap: (id) {
          setState(() {
            _activeView = id;
          });
        },
        onLogout: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        },
      ),
      body: Column(
        children: [
          // Header dinámico - Solo se muestra en Home para evitar duplicación
          if (_selectedBottomIndex == 0)
            CustomAppHeader(
              title: _getCurrentTitle(),
              subtitle: _getCurrentSubtitle(),
              userAvatar: "D",
              userName: "Diego",
              onNotificationTap: () {
                print("Notificaciones pulsadas");
              },
            ),

          // Contenido principal que cambia según la selección
          Expanded(
            child: _buildCurrentView(),
          ),
        ],
      ),

      // Bottom navigation
      bottomNavigationBar: Buttombarpato(
        initialIndex: _selectedBottomIndex,
        onTabSelected: (index) {
          setState(() {
            _selectedBottomIndex = index;
          });
        },
      ),
    );
  }
}