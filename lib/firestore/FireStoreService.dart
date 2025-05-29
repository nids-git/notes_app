import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/utils/model/NotesModel.dart';

class FireStoreService{
  final _notesCollection = FirebaseFirestore.instance.collection('notes');

  Future<void> syncNoteToCloud(NotesModel note) async{
    await _notesCollection.doc(note.id.toString()).set({
      'id' : note.id,
      'title' : note.title,
      'description' : note.description,
      'createAt' : note.createdAt.toIso8601String(),
      'isFavourite' : note.isFavourite
    });
  }

  Future<List<NotesModel>> getNotesFromCloud() async {
    final snapshot = await _notesCollection.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return NotesModel(
        id: int.parse(doc.id),
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        createdAt: DateTime.tryParse(data['createAt'] ?? '') ?? DateTime.now(),
        isFavourite: data['isFavourite'] ?? false,
      );
    }).toList();
  }

  Future<void> updateNoteToCloud(NotesModel note) async{
    await _notesCollection.doc(note.id.toString()).update({
      'title' : note.title,
      'description' : note.description,
      'createdAt' : note.createdAt,
      'isFavourite' : note.isFavourite
    });
  }

  Future<void> deleteNoteFromCloud(int id) async {
    await _notesCollection.doc(id.toString()).delete();
  }
}