import 'package:flutter/material.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acciones Rápidas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineSmall?.color,
            ),
          ),
          SizedBox(height: 16),
          QuickActionButton(
            icon: Icons.add,
            text: 'Crear Nueva Vacante',
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              // Acción crear vacante
            },
          ),
          SizedBox(height: 12),
          QuickActionButton(
            icon: Icons.visibility_outlined,
            text: 'Ver Solicitudes Pendientes',
            backgroundColor: Colors.white,
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            onPressed: () {
              // Acción ver solicitudes
            },
          ),
          SizedBox(height: 12),
          QuickActionButton(
            icon: Icons.chat_outlined,
            text: 'Contactar Estudiantes',
            backgroundColor: Colors.white,
            textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            onPressed: () {
              // Acción contactar estudiantes
            },
          ),
        ],
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
            SizedBox(width: 12),
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