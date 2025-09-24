import 'package:flutter/material.dart';
import 'package:sirs/utils/chat_overlay_wrapper.dart';

class ResidenciaScreen extends StatefulWidget {
  const ResidenciaScreen({Key? key}) : super(key: key);

  @override
  State<ResidenciaScreen> createState() => _ResidenciaScreenState();
}

class _ResidenciaScreenState extends State<ResidenciaScreen> {
  bool _showChatBot = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E7),
      body: ChatOverlayWrapper(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.holiday_village, size: 80, color: Color(0xFF8B4513)),
                SizedBox(height: 20),
                Text(
                  'Residencia',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1810),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Esta sección está en desarrollo',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        showChatBot: _showChatBot,
        onClose: () => setState(() => _showChatBot = false),
        chatContext: "residencia",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _showChatBot = !_showChatBot),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
