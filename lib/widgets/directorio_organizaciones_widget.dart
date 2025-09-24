import 'package:flutter/material.dart';

class DirectorioOrganizacionesWidget extends StatelessWidget {
  const DirectorioOrganizacionesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.apartment,
                color: Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Directorio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C1810),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Icono de organizaciones
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.groups,
              size: 40,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Explora Organizaciones',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C1810),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'Encuentra la organización perfecta para realizar tu servicio social',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Botón
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Implementar navegación a directorio
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4513),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.apartment, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Ver Organizaciones Disponibles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}