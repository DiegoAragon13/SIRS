import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // Agregar este import
import 'package:sirs/utils/themes/themes.dart';
import 'Pages/login_screen.dart';
import 'firebase_options.dart';

void main() async { // Hacer la función async
  // Asegurar que los widgets estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
    );
  }
}