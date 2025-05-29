
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppStrings.dart';
import 'package:flutter_app/utils/controller/NoteController.dart';
import 'package:provider/provider.dart';

import '../commonui/CommonWidgets.dart';
import '../utils/model/NotesModel.dart';
import '../utils/navigationUtil/NavigationHelper.dart';

class NotesDetailsScreen extends StatefulWidget {
  final int? noteId;

  NotesDetailsScreen({this.noteId});

  @override
  State<NotesDetailsScreen> createState() => _NotesDetailsScreen();

}

class _NotesDetailsScreen extends State<NotesDetailsScreen>{
   late NoteController noteController;
   NotesModel? currentNode;

   @override
  void initState() {
    super.initState();
   // noteController = Provider.of<NoteController>(context, listen: false);
    noteController = context.read<NoteController>();

    if(widget.noteId != null){
      print("Note id : ${widget.noteId}");
      currentNode = noteController.getNoteById(widget.noteId!);
      if(currentNode != null){
        noteController.titleController.text = currentNode!.title;
        noteController.descController.text = currentNode!.description;
      }
    }
  }

  @override
  void dispose() {
    noteController.clearField();
    super.dispose();
  }

   void _onSave() async {
     try{
       if(widget.noteId != null){
         await noteController.updateNote(widget.noteId!);
       }else{
         await noteController.saveNote();
       }
       noteController.clearField();
       if(mounted) Navigator.pop(context);
     }catch(e){
       showToast(context, "Failed to save note. Please try again.");
     }

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addNote),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              sizeBox(height: 12),
              _titleField(), // title UI
              sizeBox(height: 15),
              _descriptionField(), // description UI
              sizeBox(height: 15),
              _addNoteButton()
            ],
          ),
        ),
      ),

    );
  }

  _titleField() {
     return TextField(
       controller: noteController.titleController,
       decoration: InputDecoration(
           hintText: AppStrings.heading,
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
           focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10)
           )
       ),
     );
  }

  _descriptionField() {
     return  TextField(
       controller: noteController.descController,
       decoration: InputDecoration(
         hintText: AppStrings.description,
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
         ),
         focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10)
         ),
       ),
       maxLines: 9,
     );
  }

  _addNoteButton() {
     return  SizedBox(
       width: double.infinity,
       height: 55,
       child: ElevatedButton(
           onPressed: (){
             if(noteController.titleController.text.isNotEmpty &&
                 noteController.descController.text.isNotEmpty){
               _onSave();
             }else{
               showToast(context, "Fields should not be empty");
             }
           },
           style: ElevatedButton.styleFrom(
               backgroundColor: Colors.black
           ),
           child: Text(
             AppStrings.save,
             style: TextStyle(fontSize: 15, color: Colors.white),)
       ),
     );
  }

}