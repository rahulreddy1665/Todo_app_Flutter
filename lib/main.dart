import 'package:flutter/material.dart';
import 'package:task_manager/pages/edit.dart';
import 'package:task_manager/pages/home.dart';
import 'package:task_manager/pages/loader.dart';
import 'package:task_manager/pages/taskcreation.dart';

void main() =>
    runApp(MaterialApp(
      initialRoute: '/',
      routes:{
        '/': (context)=> const loader(),
        '/home':(context)=> const home(),
        '/taskcreation':(context)=>const taskcreation(),
        '/edit':(context)=>const EditTaskPage(),
      },
    ));



