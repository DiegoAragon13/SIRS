import 'package:flutter/material.dart';

class UpcomingTasksWidget extends StatelessWidget {
  const UpcomingTasksWidget({Key? key}) : super(key: key);

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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.notifications, color: Color(0xFF2D2D2D)),
              SizedBox(width: 8),
              Text(
                'Próximas Tareas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Lista de próximas tareas
          const TaskItem(
            icon: Icons.warning,
            iconColor: Color(0xFF8C1007),
            backgroundColor: Colors.transparent,
            title: 'Subir reporte mensual',
            subtitle: 'Vence en 5 días',
          ),
          const SizedBox(height: 12),

          const TaskItem(
            icon: Icons.access_time,
            iconColor: Color(0xFF8C1007),
            backgroundColor: Colors.transparent,
            title: 'Completar 40 horas',
            subtitle: 'Este mes',
          ),
          const SizedBox(height: 12),

          const TaskItem(
            icon: Icons.check_circle,
            iconColor: Color(0xFF8C1007),
            backgroundColor: Colors.transparent,
            title: 'Evaluación supervisor',
            subtitle: 'Próxima semana',
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para cada tarea
class TaskItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;

  const TaskItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
