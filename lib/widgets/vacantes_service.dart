import 'package:cloud_firestore/cloud_firestore.dart';

class VacantesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Guardar una nueva vacante en Firestore C:\Users\diego\Downloads\
  Future<void> guardarVacante(Map<String, dynamic> vacanteData) async {
    try {
      await _firestore.collection('vacantes').add({
        ...vacanteData,
        'fechaCreacion': FieldValue.serverTimestamp(),
        'estado': 'activa',
      });
    } catch (e) {
      throw 'Error al guardar la vacante: $e';
    }
  }

  // Obtener todas las vacantes
  Stream<QuerySnapshot> obtenerVacantes() {
    return _firestore
        .collection('vacantes')
        .orderBy('fechaCreacion', descending: true)
        .snapshots();
  }

  // Actualizar una vacante
  Future<void> actualizarVacante(String id, Map<String, dynamic> datos) async {
    await _firestore.collection('vacantes').doc(id).update(datos);
  }

  // Eliminar una vacante
  Future<void> eliminarVacante(String id) async {
    await _firestore.collection('vacantes').doc(id).delete();
  }
}