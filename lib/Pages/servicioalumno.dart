import 'package:flutter/material.dart';
import 'package:sirs/widgets/progreso_general_widget.dart';
import 'package:sirs/widgets/gestion_documentos_widget.dart';
import 'package:sirs/widgets/directorio_organizaciones_widget.dart';
import '../widgets/custom_headers.dart';
import 'package:sirs/utils/chat_overlay_wrapper.dart';

class ServicioAlumnoPage extends StatefulWidget {
  const ServicioAlumnoPage({Key? key}) : super(key: key);

  @override
  State<ServicioAlumnoPage> createState() => _ServicioAlumnoPageState();
}

class _ServicioAlumnoPageState extends State<ServicioAlumnoPage> {
  bool _showChatBot = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0C4),
      body: ChatOverlayWrapper(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppHeader(
                title: "Servicio Social",
                subtitle: "Gestiona tu servicio",
                userAvatar: "D",
                userName: "Diego",
                onNotificationTap: () {
                  print("Notificaciones pulsadas");
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 20),
                      ProgresoGeneralWidget(),
                      SizedBox(height: 20),
                      GestionDocumentosWidget(),
                      SizedBox(height: 20),
                      DirectorioOrganizacionesWidget(),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        showChatBot: _showChatBot,
        onClose: () => setState(() => _showChatBot = false),
        chatContext: "servicio_social",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _showChatBot = !_showChatBot),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
