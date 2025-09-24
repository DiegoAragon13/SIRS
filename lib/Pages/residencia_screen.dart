import 'package:flutter/material.dart';

class ResidenciaScreen extends StatelessWidget {
  const ResidenciaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E7),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.holiday_village,
                size: 80,
                color: Color(0xFF8B4513),
              ),
              const SizedBox(height: 20),
              const Text(
                'Residencia',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C1810),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Esta sección está en desarrollo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}