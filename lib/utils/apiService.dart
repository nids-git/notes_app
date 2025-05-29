import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/utils/model/dataModel.dart';

class ApiService {
  final dio = Dio();

  Future<List<DataModel>?> fetchPosts() async {
    try {
      var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      if(response.statusCode == 200){
        print(response.data.toString());
        final List<dynamic> data = response.data;
        return data.map((json) => DataModel.fromJson(json)).toList();
      } else {
        print(response.statusCode);
      }
    } catch(e){
      print(e.toString());
    }
    return [];
  }
}