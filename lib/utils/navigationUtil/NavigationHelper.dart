
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHelper{

   static void push(BuildContext context, Widget destination){
     Navigator.push(
         context,
         MaterialPageRoute(builder:(_) => destination)
     );
   }

   static void pushReplacement(BuildContext context, Widget destination){
     Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (_) => destination));
   }

   static void pop(BuildContext context){
     Navigator.pop(context);
   }

   static void pushNamed(BuildContext context, String routeName, {Object? arguments}){
     Navigator.pushNamed(context, routeName, arguments: arguments);
   }

   static void pushReplacementNamed(BuildContext context, String routeName, {Object? arguments}) {
     Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
   }

}