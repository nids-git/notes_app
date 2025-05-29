
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'NotesModel.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject{
   @HiveField(0)
   final int? id;
   
   @HiveField(1)
   final String title;
   
   @HiveField(2)
   final String description;

   @HiveField(3)
   final DateTime createdAt;

   @HiveField(4)
   bool isFavourite;


   NotesModel({required this.id,required this.title, required this.description, required this.createdAt,
   this.isFavourite = false});

   @override
  String toString() {
      return 'NotesModel(id: $id, title: $title, description: $description, '
          'createdAt: $createdAt, isFavourite: $isFavourite)';
  }

// convert object to map
   /*Map<String, dynamic> toJson(){
      return {
        'id': id,
        'title': title,
        'description':description
      };
   }

   // Convert Map to object
   factory NotesModel.fromJson(Map<String, dynamic> json) {
     return NotesModel(
       id: json['id'],
       title: json['title'],
       description: json['description'],
     );
   }*/
}