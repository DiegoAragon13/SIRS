import 'package:flutter/material.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({Key? key}) : super(key: key);

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
              Icon(Icons.access_time, color: Color(0xFF2D2D2D)),
              SizedBox(width: 8),
              Text(
                'Actividad Reciente',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Lista de actividades recientes
          const ActivityItem(
            icon: Icons.check_circle,
            iconColor: Color(0xFF8C1007),
            backgroundColor: Colors.transparent,
            title: 'Documento subido',
            subtitle: 'Hace 2 horas',
          ),
          const SizedBox(height: 12),

          const ActivityItem(
            icon: Icons.access_time,
            iconColor: Color(0xFF8C1007),
            backgroundColor: Colors.transparent,
            title: '20 horas registradas',
            subtitle: 'Ayer',
          ),
          const SizedBox(height: 12),

          const ActivityItem(
            icon: Icons.trending_up,
            iconColor: Color(0xFF8C1007),
            backgroundColor: Colors.transparent,
            title: 'Progreso actualizado',
            subtitle: 'Hace 3 días',
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para cada actividad
class ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;

  const ActivityItem({
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
