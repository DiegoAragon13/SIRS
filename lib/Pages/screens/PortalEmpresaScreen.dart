import 'package:flutter/material.dart';

import '../../widgets/CustomBottomNavigation.dart';
import '../../widgets/CustomHeader.dart';
import '../../widgets/CustomDrawer.dart';
import '../../widgets/FeaturedStudentsCard.dart';
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

    // Lógica para cambiar contenido según el índice
    _navigateToSection(index);
  }

  void _navigateToSection(int index) {
    // Implementar lógica de navegación aquí
    switch (index) {
      case 0: // Resumen
        break;
      case 1: // Vacantes
        break;
      case 2: // Estudiantes
        break;
      case 3: // Solicitudes
        break;
    }
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
            showDrawerButton: true,
            onMenuTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
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
                  const QuickActionsCard(),
                  const SizedBox(height: 20),
                  const FeaturedStudentsCard(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}