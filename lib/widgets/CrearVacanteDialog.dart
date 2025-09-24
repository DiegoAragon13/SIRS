import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirs/widgets/vacantes_service.dart';


class CrearVacanteDialog extends StatefulWidget {
  const CrearVacanteDialog({Key? key}) : super(key: key);

  @override
  State<CrearVacanteDialog> createState() => _CrearVacanteDialogState();
}

class _CrearVacanteDialogState extends State<CrearVacanteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _horarioController = TextEditingController();
  final _compensacionController = TextEditingController();
  final _descripcionController = TextEditingController();

  final VacantesService _vacantesService = VacantesService();
  bool _isLoading = false;

  String? _selectedArea;
  String? _selectedDuracion;
  String? _selectedModalidad;

  final List<String> _areas = [
    'Desarrollo de Software',
    'Diseño Digital',
    'Ciencia de Datos',
    'Marketing Digital',
    'Recursos Humanos',
    'Finanzas',
    'Administración'
  ];

  final List<String> _duraciones = [
    '3 meses',
    '4 meses',
    '5 meses',
    '6 meses',
    '12 meses'
  ];

  final List<String> _modalidades = [
    'Presencial',
    'Híbrido',
    'Remoto'
  ];

  List<String> _requisitosAcademicos = [];
  List<String> _habilidadesTecnicas = [];
  final _requisitoController = TextEditingController();
  final _habilidadController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _ubicacionController.dispose();
    _horarioController.dispose();
    _compensacionController.dispose();
    _descripcionController.dispose();
    _requisitoController.dispose();
    _habilidadController.dispose();
    super.dispose();
  }

  void _agregarRequisito() {
    if (_requisitoController.text.isNotEmpty) {
      setState(() {
        _requisitosAcademicos.add(_requisitoController.text);
        _requisitoController.clear();
      });
    }
  }

  void _removerRequisito(int index) {
    setState(() {
      _requisitosAcademicos.removeAt(index);
    });
  }

  void _agregarHabilidad() {
    if (_habilidadController.text.isNotEmpty) {
      setState(() {
        _habilidadesTecnicas.add(_habilidadController.text);
        _habilidadController.clear();
      });
    }
  }

  void _removerHabilidad(int index) {
    setState(() {
      _habilidadesTecnicas.removeAt(index);
    });
  }

  Future<void> _publicarVacante() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Crear el objeto de vacante
        Map<String, dynamic> vacanteData = {
          'titulo': _tituloController.text,
          'area': _selectedArea,
          'duracion': _selectedDuracion,
          'modalidad': _selectedModalidad,
          'ubicacion': _ubicacionController.text,
          'horario': _horarioController.text,
          'compensacion': _compensacionController.text,
          'descripcion': _descripcionController.text,
          'requisitosAcademicos': _requisitosAcademicos,
          'habilidadesTecnicas': _habilidadesTecnicas,
          'solicitudes': 0, // Iniciar con 0 solicitudes
          'empresa': 'Carlos Ruiz', // Puedes cambiar esto por el usuario actual
          'fechaPublicacion': FieldValue.serverTimestamp(),
          'estado': 'activa',
        };

        // Guardar en Firebase
        await _vacantesService.guardarVacante(vacanteData);

        // Mostrar mensaje de éxito y cerrar diálogo
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Vacante "${_tituloController.text}" creada exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true); // Retornar true para indicar éxito
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al crear la vacante: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 500;

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF660B05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Crear Nueva Vacante',
                    style: TextStyle(
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
                      // Información Básica
                      _buildSeccion(
                        titulo: 'Información Básica',
                        children: [
                          _buildTextField(
                            controller: _tituloController,
                            label: 'Título de la Vacante *',
                            hint: 'ej. Desarrollador Full Stack',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildDropdown(
                            value: _selectedArea,
                            label: 'Área *',
                            hint: 'Selecciona un área',
                            items: _areas,
                            onChanged: (value) {
                              setState(() {
                                _selectedArea = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Sección responsive para Duración y Modalidad
                          if (isSmallScreen) ...[
                            // Diseño vertical para pantallas pequeñas
                            _buildDropdown(
                              value: _selectedDuracion,
                              label: 'Duración *',
                              hint: 'Selecciona la duración',
                              items: _duraciones,
                              onChanged: (value) {
                                setState(() {
                                  _selectedDuracion = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildDropdown(
                              value: _selectedModalidad,
                              label: 'Modalidad *',
                              hint: 'Selecciona la modalidad',
                              items: _modalidades,
                              onChanged: (value) {
                                setState(() {
                                  _selectedModalidad = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ] else ...[
                            // Diseño horizontal para pantallas grandes
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdown(
                                    value: _selectedDuracion,
                                    label: 'Duración *',
                                    hint: 'Selecciona la duración',
                                    items: _duraciones,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedDuracion = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildDropdown(
                                    value: _selectedModalidad,
                                    label: 'Modalidad *',
                                    hint: 'Selecciona la modalidad',
                                    items: _modalidades,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedModalidad = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Este campo es obligatorio';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _ubicacionController,
                            label: 'Ubicación',
                            hint: 'ej. Ciudad de México, CDMX',
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Detalles del Puesto
                      _buildSeccion(
                        titulo: 'Detalles del Puesto',
                        children: [
                          _buildTextField(
                            controller: _horarioController,
                            label: 'Horario',
                            hint: 'ej. Lunes a Viernes 9:00 - 17:00',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _compensacionController,
                            label: 'Compensación',
                            hint: 'ej. \$8,000 - \$12,000 MXN mensuales',
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _descripcionController,
                            label: 'Descripción del Puesto *',
                            hint: 'Describe las responsabilidades, objetivos y actividades principales del puesto...',
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Requisitos Académicos
                      _buildSeccion(
                        titulo: 'Requisitos Académicos',
                        children: [
                          _buildListaDinamica(
                            controller: _requisitoController,
                            lista: _requisitosAcademicos,
                            hint: 'ej. Ingeniería en Sistemas',
                            onAgregar: _agregarRequisito,
                            onRemover: _removerRequisito,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Habilidades Técnicas
                      _buildSeccion(
                        titulo: 'Habilidades Técnicas',
                        children: [
                          _buildListaDinamica(
                            controller: _habilidadController,
                            lista: _habilidadesTecnicas,
                            hint: 'ej. React, Python, SQL',
                            onAgregar: _agregarHabilidad,
                            onRemover: _removerHabilidad,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Botones - También responsive
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 400) {
                            // Diseño vertical para pantallas muy pequeñas
                            return Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _publicarVacante,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF660B05),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    child: _isLoading
                                        ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                        : const Text('Publicar Vacante'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF660B05),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                    child: const Text('Cancelar'),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Diseño horizontal para pantallas normales
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(0xFF660B05),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text('Cancelar'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: _isLoading ? null : _publicarVacante,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF660B05),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                      : const Text('Publicar Vacante'),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildListaDinamica({
    required TextEditingController controller,
    required List<String> lista,
    required String hint,
    required VoidCallback onAgregar,
    required Function(int) onRemover,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onAgregar,
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF660B05),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (lista.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(lista.length, (index) {
              return Chip(
                label: Text(lista[index]),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => onRemover(index),
                backgroundColor: const Color(0xFF660B05).withOpacity(0.1),
              );
            }),
          ),
      ],
    );
  }
}