import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: isUrgent
            ? Border.all(color: const Color(0xFF3E0703).withOpacity(0.3))
            : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF666666), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isUrgent ? const Color(0xFF3E0703) : const Color(0xFF9E9E9E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              timeLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
