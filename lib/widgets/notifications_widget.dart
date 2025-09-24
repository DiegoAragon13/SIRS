import 'package:flutter/material.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

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
              Icon(Icons.notifications, color: Colors.transparent),
              SizedBox(width: 8),
              Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E0703),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Lista de notificaciones
          const NotificationItem(
            icon: Icons.description,
            backgroundColor: Colors.transparent,
            title: 'Sube tu reporte mensual',
            subtitle: 'El reporte de febrero debe ser entregado antes del 28/02',
            timeLabel: '2 horas',
            isUrgent: true,
          ),
          const SizedBox(height: 12),

          const NotificationItem(
            icon: Icons.access_time,
            backgroundColor: Colors.transparent,
            title: 'Te faltan 20 horas',
            subtitle: 'Completa 20 horas más para alcanzar el 70% de tu servicio social',
            timeLabel: '1 día',
            isUrgent: false,
          ),
          const SizedBox(height: 12),

          const NotificationItem(
            icon: Icons.notifications,
            backgroundColor: Colors.transparent,
            title: 'Documento validado',
            subtitle: 'Tu carta de presentación ha sido aprobada por el ITD',
            timeLabel: '3 días',
            isUrgent: false,
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para cada notificación
class NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String timeLabel;
  final bool isUrgent;

  const NotificationItem({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.isUrgent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.black87, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isUrgent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF3E0703),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'URGENTE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeLabel,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
