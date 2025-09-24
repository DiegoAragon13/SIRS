import 'package:flutter/material.dart';
import 'package:sirs/widgets/progreso_general_widget.dart';
import 'package:sirs/widgets/gestion_documentos_widget.dart';
import 'package:sirs/widgets/directorio_organizaciones_widget.dart';
import '../widgets/custom_headers.dart'; // Importar el header

class ServicioAlumnoPage extends StatefulWidget {
  const ServicioAlumnoPage({Key? key}) : super(key: key);

  @override
  State<ServicioAlumnoPage> createState() => _ServicioAlumnoPageState();
}

class _ServicioAlumnoPageState extends State<ServicioAlumnoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0C4),
      body: SafeArea(
        child: Column(
          children: [
            // Header dinámico
            CustomAppHeader(
              title: "Servicio Social",
              subtitle: "Gestiona tu servicio",
              userAvatar: "D",
              userName: "Diego",
              onNotificationTap: () {
                print("Notificaciones pulsadas");
              },
            ),

            // Contenido principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const ProgresoGeneralWidget(),
                    const SizedBox(height: 20),
                    const GestionDocumentosWidget(),
                    const SizedBox(height: 20),
                    const DirectorioOrganizacionesWidget(),
                    const SizedBox(height: 100), // Espacio para bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
