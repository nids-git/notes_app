import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../commonui/CommonText.dart';
import '../commonui/CommonWidgets.dart';
import '../utils/AppStrings.dart';
import '../utils/CommonFunctions.dart';
import '../utils/controller/NoteController.dart';
import '../utils/model/NotesModel.dart';
import '../utils/navigationUtil/NavigationHelper.dart';
import 'note_details_screen.dart';

class NotesListUI extends StatefulWidget{

  @override
  State<NotesListUI> createState() => _NotesListUIState();

}

class _NotesListUIState extends State<NotesListUI> with TickerProviderStateMixin{
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener((){
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // topbar with tabs
          appBar: _appbar(),
          body: TabBarView(
              controller: _tabController,
              children: [
                // First Tab UI
                _allNotesScreenUI(),
                // Second Tab UI
                _favouriteScreenUI(),
              ]),
          floatingActionButton:
          _currentIndex == 0 ?_floatingButton() : null
      ),
    );
  }

  _appbar(){
    return AppBar(
      title: Text(AppStrings.savedNotes,),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          buildTab(icon: Icons.notes,
              label: AppStrings.allNotes),
          buildTab(icon: Icons.star,
              label: AppStrings.favourite)
        ],
      ),
    );
  }

  _allNotesScreenUI(){
    return Consumer<NoteController>(
      builder: (context, noteProvider,_){
        final notes = noteProvider.notesList;
        if(notes.isEmpty){
          return Center(child: Text("No notes found"));
        }
        print(notes.toString());
        return  _NotesListItemUI(notes);
      },
    );
  }

  _NotesListItemUI(List<NotesModel> notes){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            mainAxisExtent: 120),
        itemCount: notes.length,
        itemBuilder: (context, index){
          final note = notes[index];
          return Card(
            child: InkWell(
              onTap: (){
                NavigationHelper.push(context, NotesDetailsScreen(noteId : note.id));
              },
              child: Stack(
                  children:[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(note.title, style: heading,),
                            Text(note.description, style: content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,),
                            Padding(padding: EdgeInsets.only(left: 20,),
                                child: Text(formatDate(note.createdAt), style: dateStyle,)),
                          ]),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          _showAlertDialog(context, note.id!);
                        },
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.delete,
                                color: Colors.red, size: 25,)),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 30,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            note.isFavourite = !note.isFavourite;
                          });
                          await note.save();
                        },
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              note.isFavourite ? Icons.favorite : Icons.favorite_border,
                              color: note.isFavourite ? Colors.red : Colors.grey, size: 25,)),
                      ),
                    )
                  ]
              ),
            ),
          );
        });
  }

  _favouriteScreenUI(){
    return Consumer<NoteController>(
      builder: (context, noteProvider,_){
        final notes = noteProvider.notesList;
        final favouriteList = notes.where((note) => note.isFavourite).toList();
        if(favouriteList.isEmpty){
          return Center(child: Text("No notes found as Favourite"));
        }
        print(favouriteList.toString());
        return  _NotesListItemUI(favouriteList);
      },
    );
  }

  _floatingButton(){
    return FloatingActionButton(
        onPressed: () async{
           NavigationHelper.push(context, NotesDetailsScreen(noteId: null,));
           Provider.of<NoteController>(context, listen: true).loadNotes(); // 👈 Add this

        },
        child: Icon(Icons.add, color: Colors.white,),
        tooltip: AppStrings.addNote,
        backgroundColor: Colors.black);
  }

  _showAlertDialog(BuildContext context, int id){
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Delete Node"),
          content: Text("Are you want to delete this item"),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("Cancel")),
            TextButton(onPressed: (){
              Provider.of<NoteController>(context, listen: false).deleteNoteByKey(id);
              Navigator.of(context).pop();
            }, child: Text("Delete", style: TextStyle(color: Colors.red),))
          ],
        )
    );
  }

}