import 'package:flutter/material.dart';

class QuickActionsCard extends StatelessWidget {
  final Function(String) onActionPressed;

  const QuickActionsCard({
    Key? key,
    required this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acciones Rápidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                // Botón Crear Nueva Vacante
                QuickActionButton(
                  icon: Icons.add,
                  text: 'Crear Nueva Vacante',
                  backgroundColor: const Color(0xFF660B05),
                  textColor: Colors.white,
                  onPressed: () => onActionPressed('crear_vacante'),
                ),
                const SizedBox(height: 12),
                // Botón Ver Vacantes
                QuickActionButton(
                  icon: Icons.work_outline,
                  text: 'Ver Vacantes',
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF660B05),
                  onPressed: () => onActionPressed('ver_vacantes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const QuickActionButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: backgroundColor == Colors.white ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: backgroundColor == Colors.white
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}