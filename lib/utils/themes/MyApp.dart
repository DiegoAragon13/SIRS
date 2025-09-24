import 'package:flutter/material.dart';
import 'package:sirs/utils/themes/themes.dart';
// Importa tu clase de temas
import '../../Pages/screens/PortalEmpresaScreen.dart';


// Importa todos los widgets aquí
// import 'widgets/custom_header.dart';
// import 'widgets/welcome_section.dart';
// import 'widgets/stats_grid.dart';
// import 'widgets/quick_actions.dart';
// import 'widgets/featured_students.dart';
// import 'widgets/bottom_navigation.dart';
// import 'screens/portal_empresa_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Empresa',
      debugShowCheckedModeBanner: false,
      // Usa tus temas personalizados
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system, // Se adapta al tema del sistema
      home: const PortalEmpresaScreen(),
    );
  }
}


// Aquí incluirías todos los widgets que creamos anteriormente
// Por brevedad, solo muestro la estructura del main.dart

// ESTRUCTURA RECOMENDADA DE CARPETAS:
// lib/
// ├── main.dart
// ├── screens/
// │   └── portal_empresa_screen.dart
// └── widgets/
//     ├── custom_header.dart
//     ├── welcome_section.dart
//     ├── stats_grid.dart
//     ├── quick_actions.dart
//     ├── featured_students.dart
//     └── bottom_navigation.dart