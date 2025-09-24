import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // fondo suave según tema
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.trending_up, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Resumen de Progreso',
                style: theme.textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Servicio Social Progress
          Row(
            children: [
              Icon(Icons.people, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Servicio Social',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF3E0703), // estado activo
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Activo - 65%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress Bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: theme.colorScheme.secondary.withOpacity(0.4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Horas completadas y restantes
          Row(
            children: [
              Expanded(
                child: _buildHoursCard(
                  context,
                  'Horas Completadas',
                  '312',
                  theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildHoursCard(
                  context,
                  'Horas Restantes',
                  '168',
                  Color(0xFF3E0703),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Total requerido
          _buildTotalRequiredCard(context),
          const SizedBox(height: 20),

          // Residencias profesionales
          _buildResidenciasSection(context),
        ],
      ),
    );
  }

  Widget _buildHoursCard(
      BuildContext context, String title, String hours, Color color) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hours,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRequiredCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Total Requerido',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '500',
            style: theme.textTheme.headlineSmall?.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildResidenciasSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.assignment, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              'Residencias',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF3E0703),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Pendiente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning, color: Color(0xFF3E0703), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Completa tu Servicio Social al 100% para acceder a Residencias',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
