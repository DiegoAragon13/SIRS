import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DetallesVacanteDialog extends StatelessWidget {
  final Map<String, dynamic> vacante;

  const DetallesVacanteDialog({Key? key, required this.vacante}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFF660B05),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  vacante['titulo'] ?? 'Sin título',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Contenido
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información básica
                    _buildSeccion(
                      titulo: 'Información Básica',
                      children: [
                        _buildInfoRow('Área:', vacante['area'] ?? 'No especificado'),
                        _buildInfoRow('Duración:', vacante['duracion'] ?? 'No especificado'),
                        _buildInfoRow('Modalidad:', vacante['modalidad'] ?? 'No especificado'),
                        _buildInfoRow('Ubicación:', vacante['ubicacion'] ?? 'No especificado'),
                        _buildInfoRow('Solicitudes:', '${vacante['solicitudes'] ?? 0} solicitudes'),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Detalles del puesto
                    _buildSeccion(
                      titulo: 'Detalles del Puesto',
                      children: [
                        _buildInfoRow('Horario:', vacante['horario'] ?? 'No especificado'),
                        _buildInfoRow('Compensación:', vacante['compensacion'] ?? 'No especificado'),
                        _buildSubseccion('Descripción:', vacante['descripcion'] ?? 'No hay descripción'),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Requisitos académicos
                    if ((vacante['requisitosAcademicos'] as List?)?.isNotEmpty ?? false)
                      Column(
                        children: [
                          _buildSeccion(
                            titulo: 'Requisitos Académicos',
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  (vacante['requisitosAcademicos'] as List).length,
                                      (index) => _buildChip((vacante['requisitosAcademicos'] as List)[index]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),

                    // Habilidades técnicas
                    if ((vacante['habilidadesTecnicas'] as List?)?.isNotEmpty ?? false)
                      _buildSeccion(
                        titulo: 'Habilidades Técnicas',
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                              (vacante['habilidadesTecnicas'] as List).length,
                                  (index) => _buildChip((vacante['habilidadesTecnicas'] as List)[index]),
                            ),
                          ),
                        ],
                      ),

                    // Información adicional
                    _buildSeccion(
                      titulo: 'Información Adicional',
                      children: [
                        _buildInfoRow('Empresa:', vacante['empresa'] ?? 'No especificado'),
                        _buildInfoRow('Estado:', vacante['estado'] ?? 'No especificado'),
                        if (vacante['fechaPublicacion'] != null)
                          _buildInfoRow(
                            'Fecha de publicación:',
                            _formatearFecha(vacante['fechaPublicacion']),
                          ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Botones de acción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF660B05),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeccion({required String titulo, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF660B05),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSubseccion(String titulo, String contenido) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          contenido,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String texto) {
    return Chip(
      label: Text(
        texto,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: const Color(0xFF660B05).withOpacity(0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  String _formatearFecha(dynamic fecha) {
    try {
      if (fecha is Timestamp) {
        return DateFormat('dd/MM/yyyy').format(fecha.toDate());
      }
      return 'Fecha no disponible';
    } catch (e) {
      return 'Fecha no disponible';
    }
  }
}