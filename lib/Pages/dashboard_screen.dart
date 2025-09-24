import 'package:flutter/material.dart';
import 'package:sirs/Pages/servicioalumno.dart';
import '../widgets/buttombarpato.dart';
import '../widgets/progress_widget.dart';
import '../widgets/recent_activity_widget.dart';
import '../widgets/upcoming_tasks_widget.dart';
import '../widgets/notifications_widget.dart';
import '../widgets/custom_headers.dart';
import 'package:sirs/utils/chat_overlay_wrapper.dart';
import '../Pages/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _activeView = "overview";
  int _selectedBottomIndex = 0;
  bool _showChatBot = false;

  final List<NavigationItem> _navigationItems =
  DashboardNavigationHelper.getDefaultNavigationItems();

  Widget _buildCurrentView() {
    switch (_selectedBottomIndex) {
      case 0:
        return _buildHomeView();
      case 1:
        return const ServicioAlumnoPage();
      case 2:
        return _buildResidenciaView();
      default:
        return _buildHomeView();
    }
  }

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
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildResidenciaView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.holiday_village, size: 80, color: Color(0xFF8B4513)),
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
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

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
          setState(() => _activeView = id);
        },
        onLogout: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        },
      ),
      body: ChatOverlayWrapper(
        child: Column(
          children: [
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
            Expanded(child: _buildCurrentView()),
          ],
        ),
        showChatBot: _showChatBot,
        onClose: () => setState(() => _showChatBot = false),
        chatContext: "Soy un bot, listo para ayudarte en los temas de servicio social y residencia. ¿En qué puedo ayudarte hoy?",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _showChatBot = !_showChatBot),
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: Buttombarpato(
        initialIndex: _selectedBottomIndex,
        onTabSelected: (index) {
          setState(() => _selectedBottomIndex = index);
        },
      ),
    );
  }
}
