import 'package:flutter/material.dart';

import 'package:provider/provider.dart'; // Add this import

import 'providers/note_provider.dart';

import 'screens/home_screen.dart';



void main() {

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider(create: (_) => NoteProvider()),

      ],

      child: const MyApp(),

    ),

  );

}



class MyApp extends StatelessWidget {

  const MyApp({super.key}); // Add this



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'My Notepad',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: const HomeScreen(),

    );

  }

}



