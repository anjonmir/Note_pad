import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart'; // Add this import

import 'package:path_provider/path_provider.dart'; // Add this import

import 'package:path/path.dart'; // Add this import

import '../models/note.dart';

import 'dart:io';



class NoteProvider with ChangeNotifier {

  List<Note> _notes = [];

  static Database? _database;



  List<Note> get notes => _notes;



  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;

  }



  Future<Database> _initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "notes.db");



    return await openDatabase(

      path,

      version: 1,

      onCreate: (db, version) async {

        await db.execute('''

          CREATE TABLE notes (

            id INTEGER PRIMARY KEY AUTOINCREMENT,

            title TEXT,

            content TEXT,

            createdAt TEXT,

            imagePath TEXT,

            audioPath TEXT,

            pdfPath TEXT

          )

        ''');

      },

    );

  }



  Future<void> loadNotes() async {

    final db = await database;

    List<Map<String, dynamic>> maps = await db.query("notes");

    _notes = maps.map((e) => Note.fromMap(e)).toList();

    notifyListeners();

  }



  Future<void> addNote(Note note) async {

    final db = await database;

    await db.insert("notes", note.toMap());

    await loadNotes();

  }



  Future<void> updateNote(Note updatedNote) async {

    final db = await database;

    await db.update(

      "notes",

      updatedNote.toMap(),

      where: "id = ?",

      whereArgs: [updatedNote.id],

    );

    await loadNotes();

  }



  Future<void> deleteNote(int id) async {

    final db = await database;

    await db.delete("notes", where: "id = ?", whereArgs: [id]);

    await loadNotes();

  }

}


