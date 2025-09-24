import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GestionDocumentosWidget extends StatefulWidget {
  const GestionDocumentosWidget({Key? key}) : super(key: key);

  @override
  State<GestionDocumentosWidget> createState() => _GestionDocumentosWidgetState();
}

class _GestionDocumentosWidgetState extends State<GestionDocumentosWidget> {
  final List<_Documento> documentos = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.upload_file, color: Colors.grey[600], size: 24),
              const SizedBox(width: 8),
              const Text(
                'Gestión de Documentos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C1810)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: () => _mostrarModalSubida(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text(
                    'Subir documento',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2C1810)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'PDF, DOC, DOCX, JPG, PNG hasta 10MB',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Documentos subidos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2C1810))),
          const SizedBox(height: 12),

          ...documentos.map((doc) => _buildDocumentItem(doc)).toList(),
        ],
      ),
    );
  }

  void _mostrarModalSubida(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subir Documento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C1810))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _seleccionarArchivo(context),
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Seleccionar archivo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF660B05),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: const Color(0xFFF5F3E7), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tipos de archivo permitidos:', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C1810))),
                          const SizedBox(height: 8),
                          Text('• PDF (.pdf)\n• Word (.doc, .docx)\n• Imagen (.jpg, .png)\n• Tamaño máximo: 10MB', style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _seleccionarArchivo(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf','doc','docx','jpg','png'],
      withData: true,
    );

    if (result != null) {
      final file = result.files.single;

      if (file.size > 10 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Archivo demasiado grande (máx. 10MB).'), backgroundColor: Colors.red));
        return;
      }

      double? probability;
      if (file.extension == 'jpg' || file.extension == 'png') {
        try {
          // Bytes del archivo seleccionado
          final Uint8List selectedBytes = file.bytes ?? await File(file.path!).readAsBytes();
          // Bytes del asset correctamente cargado
          final Uint8List assetBytes = (await rootBundle.load('assets/images/prueba.jpg')).buffer.asUint8List();

          // Comparación con Gemini
          final response = await Gemini.instance.textAndImage(
            text: '¿Coincide esta imagen con la de referencia?',
            images: [assetBytes, selectedBytes],
          );

          final outputText = response?.content?.parts?.last.text ?? '';
          probability = double.tryParse(RegExp(r'\d+(\.\d+)?').firstMatch(outputText)?.group(0) ?? '0') ?? 0;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Probabilidad de coincidencia: ${probability.toStringAsFixed(2)}%'),
            backgroundColor: probability > 80 ? Colors.green : Colors.orange,
          ));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al comparar imágenes: $e'), backgroundColor: Colors.red));
        }
      }

      setState(() {
        documentos.add(_Documento(file.name, DateTime.now(), file.extension ?? '', probability));
      });

      Navigator.pop(context);
    }
  }

  Widget _buildDocumentItem(_Documento doc) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: const Color(0xFFF5F3E7), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(doc.iconData, color: Colors.grey[600], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2C1810))),
                Text('${doc.date.day}/${doc.date.month}/${doc.date.year}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                if (doc.probability != null)
                  Text('Coincidencia: ${doc.probability!.toStringAsFixed(2)}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: doc.probability! > 80 ? Colors.green : Colors.orange)),
              ],
            ),
          ),
          Icon(Icons.visibility, color: Colors.grey[600], size: 24),
          const SizedBox(width: 8),
          Icon(Icons.download, color: Colors.grey[600], size: 24),
        ],
      ),
    );
  }
}

extension on Part {
  get text => null;
}

class _Documento {
  final String name;
  final DateTime date;
  final String type;
  final double? probability;

  _Documento(this.name, this.date, this.type, this.probability);

  IconData get iconData {
    switch (type.toLowerCase()) {
      case 'pdf': return Icons.picture_as_pdf;
      case 'doc':
      case 'docx': return Icons.description;
      case 'jpg':
      case 'png': return Icons.image;
      default: return Icons.insert_drive_file;
    }
  }
}
