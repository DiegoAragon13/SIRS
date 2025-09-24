import 'package:flutter/material.dart';
import '../widgets/custom_headers.dart';
import 'Dashboard/overview_screen_new.dart';
import 'Dashboard/students_screen_new.dart';
import 'Dashboard/documents_screen_new.dart';
import 'Dashboard/companies_screen_new.dart';

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

class NewAdminDashboard extends StatefulWidget {
  const NewAdminDashboard({Key? key}) : super(key: key);

  @override
  State<NewAdminDashboard> createState() => _NewAdminDashboardState();
}

class _NewAdminDashboardState extends State<NewAdminDashboard> {
  String _activeView = "overview";
  
  final String userName = "Administrador";
  final String userAvatar = "A";

  final List<NavigationItem> _navigationItems = [
    NavigationItem(id: "overview", label: "Resumen General", icon: Icons.bar_chart),
    NavigationItem(id: "students", label: "Estudiantes", icon: Icons.people),
    NavigationItem(id: "documents", label: "Documentos", icon: Icons.file_copy),
    NavigationItem(id: "companies", label: "Empresas", icon: Icons.business),
  ];

  void _setActiveView(String viewId) {
    setState(() {
      _activeView = viewId;
    });
  }

  void _onLogout() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Using theme background
        body: Column(
          children: [
            // Header Modular (funciona para móvil y desktop)
            CustomAppHeader(
              title: 'Panel Administrativo ITD',
              subtitle: 'Gestión y Supervisión Académica',
              userAvatar: userAvatar,
              userName: userName,
              onLogout: _onLogout,
              onNotificationTap: () {
                // Show notifications
              },
            ),
            
            // Desktop Navigation
            if (MediaQuery.of(context).size.width >= 1024)
              _buildDesktopNavigation(),
            
            // Main Content
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
        
        // Mobile Bottom Navigation
        bottomNavigationBar: MediaQuery.of(context).size.width < 1024 
            ? _buildMobileBottomNavigation() 
            : null,
        
        // Mobile Drawer
        drawer: MediaQuery.of(context).size.width < 1024 
            ? _buildMobileDrawer() 
            : null,
    );
  }



  Widget _buildDesktopNavigation() {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: _navigationItems.map((item) {
              final isActive = _activeView == item.id;
              return GestureDetector(
                onTap: () => _setActiveView(item.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isActive ? const Color(0xFF660B05) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 16,
                        color: isActive 
                            ? const Color(0xFF660B05) 
                            : const Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isActive 
                              ? const Color(0xFF660B05) 
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Panel Administrativo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Gestión ITD',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            ..._navigationItems.map((item) {
              final isActive = _activeView == item.id;
              return GestureDetector(
                onTap: () => _setActiveView(item.id),
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
          ],
        ),
      ),
    );
  }

  Widget _buildMobileBottomNavigation() {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: _navigationItems.map((item) {
            final isActive = _activeView == item.id;
            return Expanded(
              child: GestureDetector(
                onTap: () => _setActiveView(item.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: isActive 
                      ? const Color(0xFF660B05).withOpacity(0.05) 
                      : Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: isActive 
                            ? const Color(0xFF660B05) 
                            : const Color(0xFF6B7280),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label.split(' ')[0], // First word only
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isActive 
                              ? const Color(0xFF660B05) 
                              : const Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width >= 1024 ? 32 : 24),
      child: _getCurrentScreen(),
    );
  }

  Widget _getCurrentScreen() {
    switch (_activeView) {
      case "overview":
        return OverviewScreenNew(userName: userName);
      case "students":
        return const StudentsScreenNew();
      case "documents":
        return const DocumentsScreenNew();
      case "companies":
        return const CompaniesScreenNew();
      default:
        return OverviewScreenNew(userName: userName);
    }
  }
}