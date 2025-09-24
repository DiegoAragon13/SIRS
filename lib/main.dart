import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sirs/utils/themes/themes.dart';
import 'Pages/login_screen.dart';
import 'package:sirs/Pages/screens/main_navigation_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'config/api_keys.dart';

void main() async {
  // Asegurar que los widgets estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Gemini.init(
    apiKey: "AIzaSyAYmS9BusScCrkjnGC3X4wYt8_y8nVA_Hg",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITD Plataforma Educativa',
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      // Rutas nombradas para mejor navegación
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainNavigationScreen(),
      },
    );
  }
}