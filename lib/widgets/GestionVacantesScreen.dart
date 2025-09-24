import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirs/widgets/vacantes_service.dart';
import '../widgets/CustomHeader.dart';
import '../widgets/CustomDrawer.dart';
import 'CrearVacanteDialog.dart';
import 'DetallesVacanteDialog.dart';

class GestionVacantesScreen extends StatefulWidget {
  const GestionVacantesScreen({Key? key}) : super(key: key);

  @override
  State<GestionVacantesScreen> createState() => _GestionVacantesScreenState();
}

class _GestionVacantesScreenState extends State<GestionVacantesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final VacantesService _vacantesService = VacantesService();
  int _drawerSelectedIndex = 1;

  void _handleNavigation(int index) {
    setState(() {
      _drawerSelectedIndex = index;
    });

    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(context);
    }

    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        break;
      case 2:
        _showComingSoonMessage('Estudiantes');
        break;
      case 3:
        _showComingSoonMessage('Solicitudes');
        break;
    }
  }

  void _showComingSoonMessage(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$section - Próximamente'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  void _onNotificationTap() {
    _showComingSoonMessage('Notificaciones');
  }

  void _mostrarDialogoCrearVacante() {
    showDialog(
      context: context,
      builder: (context) => const CrearVacanteDialog(),
    ).then((resultado) {
      if (resultado == true) {
        setState(() {});
      }
    });
  }

  void _mostrarDetallesVacante(BuildContext context, String vacanteId) {
    FirebaseFirestore.instance
        .collection('vacantes')
        .doc(vacanteId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        final vacanteData = doc.data() as Map<String, dynamic>;
        showDialog(
          context: context,
          builder: (context) => DetallesVacanteDialog(vacante: vacanteData),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La vacante no existe'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar los detalles: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade50,
      drawer: CustomDrawer(
        selectedIndex: _drawerSelectedIndex,
        onItemSelected: _handleNavigation,
      ),
      body: Column(
        children: [
          CustomHeader(
            userAvatar: 'CR',
            userName: 'Carlos Ruiz',
            onLogout: _onLogout,
            onNotificationTap: _onNotificationTap,
            onMenuTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            showDrawerButton: true,
            showUserInfo: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gestión de Vacantes',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF660B05),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Administra tus vacantes publicadas',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildGestionVacantesSection(),
                  const SizedBox(height: 30),

                  _buildVacantesListFromFirebase(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildGestionVacantesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tus Vacantes Publicadas',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: _mostrarDialogoCrearVacante,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF660B05),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              'Nueva Vacante',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildVacantesListFromFirebase() {
    return StreamBuilder<QuerySnapshot>(
      stream: _vacantesService.obtenerVacantes(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        final vacantes = snapshot.data!.docs;

        return Column(
          children: vacantes.map((doc) {
            final vacante = doc.data() as Map<String, dynamic>;
            return _buildVacanteCardFromFirebase(
              id: doc.id,
              titulo: vacante['titulo'] ?? 'Sin título',
              area: vacante['area'] ?? 'Sin área',
              duracion: vacante['duracion'] ?? 'Sin duración',
              solicitudes: vacante['solicitudes'] ?? 0,
              requisitos: List<String>.from(vacante['habilidadesTecnicas'] ?? []),
              tieneSolicitudes: (vacante['solicitudes'] ?? 0) > 0,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.work_outline,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          const Text(
            'No hay vacantes publicadas',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Crea tu primera vacante para comenzar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacanteCardFromFirebase({
    required String id,
    required String titulo,
    required String area,
    required String duracion,
    required int solicitudes,
    required List<String> requisitos,
    required bool tieneSolicitudes,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            area,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.access_time,
                text: duracion,
                isActive: tieneSolicitudes,
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                icon: Icons.people_outline,
                text: '$solicitudes solicitudes',
                isActive: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (requisitos.isNotEmpty) ...[
            const Text(
              'Requisitos:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: requisitos.map((req) => _buildRequisitoChip(req)).toList(),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                _mostrarDetallesVacante(context, id);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF660B05),
                side: const BorderSide(color: Color(0xFF660B05)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ver Detalles'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text, required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF660B05).withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? const Color(0xFF660B05).withOpacity(0.3) : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isActive ? const Color(0xFF660B05) : Colors.grey.shade600,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFF660B05) : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequisitoChip(String requisito) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(
        requisito,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(Icons.bar_chart, 'Resumen', 0),
          _buildNavItem(Icons.work_outline, 'Vacantes', 1),
          _buildNavItem(Icons.school_outlined, 'Estudiantes', 2),
          _buildNavItem(Icons.assignment_outlined, 'Solicitudes', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _drawerSelectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _handleNavigation(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFF660B05) : Colors.grey.shade500,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF660B05) : Colors.grey.shade500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}