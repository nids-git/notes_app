import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTab({required IconData icon, required String label}){
 return Tab(child: Row(
   mainAxisSize: MainAxisSize.min,
   children: [Icon(icon),
     Text(label)],)
 );
}

Widget sizeBox({required double? height}){
  return SizedBox(
    height: height,
  );
}

void showToast(BuildContext context, String message){
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message),
      duration: Duration(seconds: 2),)
  );
}