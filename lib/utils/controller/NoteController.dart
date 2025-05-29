
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/firestore/FireStoreService.dart';
import 'package:flutter_app/utils/preference/NoteStorage.dart';
import 'package:hive/hive.dart';

import '../../hive/HiveFunctions.dart';
import '../model/NotesModel.dart';

class NoteController extends ChangeNotifier{
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final fireStoreService = FireStoreService();

  late Box<NotesModel> notesBox;
  List<NotesModel> _notesList = [];

  List<NotesModel> get notesList => _notesList;

  NoteController(){
    loadNotes();
  }

  Future<void> saveNote() async {
    final note = NotesModel(
      title: titleController.text.trim(),
      description: descController.text.trim(),
      id:0,
      createdAt: DateTime.now(),
    );
    await addNote(note);
    await loadNotes();
    clearField();
    notifyListeners();
  }

  Future<void> updateNote(int key) async {
     final note = NotesModel(
       title: titleController.text.trim(),
       description: descController.text.trim(),
       id:key,
       createdAt: DateTime.now()
     );
     await notesBox.put(key, note);
     _notesList = notesBox.values.toList();
     fireStoreService.updateNoteToCloud(note);
     notifyListeners();
  }

  Future<void> loadNotes() async{
     notesBox = await Hive.openBox<NotesModel>('notes');

    _notesList = notesBox.values.toList();
    notifyListeners();

    for (var key in notesBox.keys) {
      print("Key: $key => Note ID: ${notesBox.get(key)?.id}");
    }
  }

  void deleteNoteByKey(dynamic key) async{
    print("delete this: $key");
    await notesBox.delete(key);
    _notesList = notesBox.values.toList();
    fireStoreService.deleteNoteFromCloud(key);
    notifyListeners();
  }

  void clearField() {
    titleController.clear();
    descController.clear();
  }

  NotesModel? getNoteById(int id){
    return notesBox.get(id);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}