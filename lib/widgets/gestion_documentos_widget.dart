import 'package:flutter/material.dart';

class GestionDocumentosWidget extends StatelessWidget {
  const GestionDocumentosWidget({Key? key}) : super(key: key);

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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.upload_file,
                color: Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Gestión de Documentos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C1810),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Área de subida
          GestureDetector(
            onTap: () {
              // Implementar lógica de subida
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Subir documento',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'PDF, DOC, DOCX hasta 10MB',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Lista de documentos
          const Text(
            'Documentos subidos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C1810),
            ),
          ),
          const SizedBox(height: 12),

          // Documento 1
          _buildDocumentItem(
            'Carta de Presentación.pdf',
            '2024-01-15',
            Icons.picture_as_pdf,
            const Color(0xFF660B05),
            Icons.check_circle,
          ),
          const SizedBox(height: 8),

          // Documento 2
          _buildDocumentItem(
            'Programa de Trabajo.docx',
            '2024-01-20',
            Icons.description,
            const Color(0xFF660B05),
            Icons.schedule,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String name, String date, IconData fileIcon, Color statusColor, IconData statusIcon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3E7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            fileIcon,
            color: Colors.grey[600],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C1810),
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.visibility,
            color: Colors.grey[600],
            size: 24,
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.download,
            color: Colors.grey[600],
            size: 24,
          ),
        ],
      ),
    );
  }
}