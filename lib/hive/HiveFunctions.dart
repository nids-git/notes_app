
import 'package:flutter_app/firestore/FireStoreService.dart';
import 'package:hive/hive.dart';

import '../utils/model/NotesModel.dart';

Box<NotesModel> box = Hive.box<NotesModel>('notes');
final firestoreService = FireStoreService();

Future<void> addNote(NotesModel noteModel) async{
  final lastId = box.values.isEmpty ? 0 : box.values.last.id;
  final newId = lastId! + 1;

  final notes = NotesModel(
    title: noteModel.title,
    description: noteModel.description,
      id: newId,
    createdAt: noteModel.createdAt
  );

  await box.put(newId,notes);
  await firestoreService.syncNoteToCloud(notes);
}

Future<List<NotesModel>> loadNotesFromDB() async{
   box = await Hive.openBox<NotesModel>('notes');
   return box.values.toList();
}