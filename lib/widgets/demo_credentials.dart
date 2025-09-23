import 'package:flutter/material.dart';

class DemoCredentials extends StatelessWidget {
  const DemoCredentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE9ECEF),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Credenciales de demostración:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6C757D),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                'Email: ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
              Text(
                'cualquier@email.com',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Text(
                'Contraseña: ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
              Text(
                'cualquier contraseña',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}