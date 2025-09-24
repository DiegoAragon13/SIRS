import 'package:flutter/material.dart';
import 'package:sirs/Pages/dashboard_screen.dart';
import 'package:sirs/Pages/servicioalumno.dart';
import 'package:sirs/Pages/residencia_screen.dart';
import 'package:sirs/widgets/buttombarpato.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState(); // Cambiado * por _
}

class _MainNavigationScreenState extends State<MainNavigationScreen> { // Cambiado * por _
  int _selectedIndex = 0; // Cambiado * por _

  // Lista de pantallas
  late final List<Widget> _screens; // Cambiado * por _

  @override
  void initState() {
    super.initState();
    _screens = [ // Cambiado * por _
      const DashboardScreen(), // Dashboard sin bottom nav
      const ServicioAlumnoPage(), // Tu pantalla de servicio social
      const ResidenciaScreen(), // Pantalla placeholder para residencia
    ];
  }

  void _onTabSelected(int index) { // Cambiado * por _
    setState(() {
      _selectedIndex = index; // Cambiado * por _
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Cambiado * por _
        children: _screens, // Cambiado * por _
      ),
      bottomNavigationBar: Buttombarpato(
        initialIndex: _selectedIndex, // Cambiado * por _
        onTabSelected: _onTabSelected, // Cambiado * por _
      ),
    );
  }
}
