
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/NotesModel.dart';

class NoteStorage{
  static const String _noteKey = 'saved_note';

 /* Future<void> saveNote(NotesModel notes) async{
    final prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(notes.toJson());
    await prefs.setString(_noteKey, json);
  }*/

  /*Future<NoteModel?> loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_noteKey);

    if (jsonString != null) {
      Map<String, dynamic> map = jsonDecode(jsonString);
      return NoteModel.fromJson(map);
    }
    return null;
  }

  Future<void> clearNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_noteKey);
  }*/
}