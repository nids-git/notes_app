import 'package:flutter/foundation.dart';

class DataModel {
  final int id;
  final String title;
  final String body;

  DataModel({required this.id, required this.title, required this.body});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
  @override
  String toString() {
    return 'DataModel(id: $id, title: $title)';
  }
}
