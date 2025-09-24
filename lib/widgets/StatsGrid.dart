import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        StatCard(
          title: 'Vacantes\nActivas',
          value: '8',
          subtitle: 'Posiciones\ndisponibles',
          backgroundColor: Colors.white,
        ),
        StatCard(
          title: 'Solicitudes',
          value: '45',
          subtitle: 'Aplicaciones\nrecibidas',
          backgroundColor: Colors.white,
        ),
        StatCard(
          title: 'Estudiantes\nActivos',
          value: '12',
          subtitle: 'En\nresidencias',
          backgroundColor: Colors.white,
        ),
        StatCard(
          title: 'Proyectos',
          value: '23',
          subtitle: 'Completados',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color backgroundColor;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.headlineSmall?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}