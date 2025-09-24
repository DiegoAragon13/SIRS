import 'package:flutter/material.dart';

class OverviewScreenNew extends StatelessWidget {
  final String userName;

  const OverviewScreenNew({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = {
      'totalStudents': 245,
      'activeServiceStudents': 89,
      'activeResidencyStudents': 34,
      'pendingDocuments': 23,
      'registeredCompanies': 45,
    };

    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Welcome Header
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Bienvenido, $userName',
                  style: TextStyle(
                    fontSize: isDesktop ? 30 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Panel de control para la gestión académica del instituto',
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    color: const Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          SizedBox(height: isDesktop ? 32 : 24),

          // Stats Cards
          if (isDesktop)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 5,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.8,
              children: [
                _buildStatCard(
                  title: 'Total Estudiantes',
                  value: '${stats['totalStudents']}',
                  subtitle: 'Estudiantes registrados',
                  icon: Icons.people,
                ),
                _buildStatCard(
                  title: 'Servicio Social',
                  value: '${stats['activeServiceStudents']}',
                  subtitle: 'Estudiantes activos',
                  icon: Icons.school,
                ),
                _buildStatCard(
                  title: 'Residencias',
                  value: '${stats['activeResidencyStudents']}',
                  subtitle: 'En residencias',
                  icon: Icons.business,
                ),
                _buildStatCard(
                  title: 'Documentos',
                  value: '${stats['pendingDocuments']}',
                  subtitle: 'Pendientes revisión',
                  icon: Icons.description,
                ),
                _buildStatCard(
                  title: 'Empresas',
                  value: '${stats['registeredCompanies']}',
                  subtitle: 'Empresas registradas',
                  icon: Icons.business,
                ),
              ],
            )
          else
            Column(
              children: [
                // First row - larger card
                Container(
                  width: double.infinity,
                  child: _buildStatCard(
                    title: 'Total Estudiantes',
                    value: '${stats['totalStudents']}',
                    subtitle: 'Estudiantes registrados',
                    icon: Icons.people,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Second row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Servicio Social',
                        value: '${stats['activeServiceStudents']}',
                        subtitle: 'Estudiantes activos',
                        icon: Icons.school,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Residencias',
                        value: '${stats['activeResidencyStudents']}',
                        subtitle: 'En residencias',
                        icon: Icons.business,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Third row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Documentos',
                        value: '${stats['pendingDocuments']}',
                        subtitle: 'Pendientes revisión',
                        icon: Icons.description,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Empresas',
                        value: '${stats['registeredCompanies']}',
                        subtitle: 'Empresas registradas',
                        icon: Icons.business,
                      ),
                    ),
                  ],
                ),
              ],
            ),

          SizedBox(height: isDesktop ? 32 : 24),

          // Recent Activity Card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Header
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Actividad Reciente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                // Activities List
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Column(
                    children: [
                      _buildActivityItem(
                        student: 'Juan Pérez',
                        action: 'Subió reporte mensual',
                        time: 'Hace 2 horas',
                        status: 'pending',
                      ),
                      const SizedBox(height: 16),
                      _buildActivityItem(
                        student: 'María González',
                        action: 'Completó servicio social',
                        time: 'Hace 4 horas',
                        status: 'completed',
                      ),
                      const SizedBox(height: 16),
                      _buildActivityItem(
                        student: 'Carlos Ruiz',
                        action: 'Solicitó residencia',
                        time: 'Hace 1 día',
                        status: 'pending',
                      ),
                      const SizedBox(height: 16),
                      _buildActivityItem(
                        student: 'Ana López',
                        action: 'Documento validado',
                        time: 'Hace 2 días',
                        status: 'approved',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Add bottom padding for mobile bottom navigation
          SizedBox(height: MediaQuery.of(context).size.width < 1024 ? 80 : 0),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                Icon(
                  icon,
                  size: 16,
                  color: const Color(0xFF6B7280),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Value
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 4),
            
            // Subtitle
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required String student,
    required String action,
    required String time,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                student.split(' ').map((n) => n[0]).join(''),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                Text(
                  action,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          
          // Time and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(status),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getStatusTextColor(status),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return const Color(0xFF660B05); // Primary color
      case 'approved':
        return const Color(0xFFF3F4F6); // Secondary/muted
      case 'pending':
      default:
        return Colors.transparent;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.white;
      case 'approved':
        return const Color(0xFF374151);
      case 'pending':
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'Completado';
      case 'approved':
        return 'Aprobado';
      case 'pending':
      default:
        return 'Pendiente';
    }
  }
}