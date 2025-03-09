import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:provider/provider.dart';

import '../models/note.dart';

import '../providers/note_provider.dart';

import 'package:uuid/uuid.dart';



class NoteEditor extends StatefulWidget {

  final Note? note;



  const NoteEditor({super.key, this.note}); // Add this



  @override

  _NoteEditorState createState() => _NoteEditorState();

}



class _NoteEditorState extends State<NoteEditor> {

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  File? _image;

  final ImagePicker _picker = ImagePicker();



  @override

  void initState() {

    super.initState();

    if (widget.note != null) {

      _titleController.text = widget.note!.title;

      _contentController.text = widget.note!.content;

      if (widget.note!.imagePath != null) {

        _image = File(widget.note!.imagePath!);

      }

    }

  }



  Future<void> _pickImage() async {

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {

      setState(() {

        _image = File(pickedFile.path);

      });

    }

  }



  Future<void> _saveNote() async {

    final title = _titleController.text.trim();

    final content = _contentController.text.trim();



    if (title.isEmpty && content.isEmpty) return;



    final noteProvider = Provider.of<NoteProvider>(context, listen: false);



    final newNote = Note(

      id: widget.note?.id ?? const Uuid().v4(), // Use existing ID or generate a new one

      title: title,

      content: content,

      createdAt: DateTime.now(),

      imagePath: _image?.path,

    );



    if (widget.note == null) {

      await noteProvider.addNote(newNote);

    } else {

      await noteProvider.updateNote(newNote);

    }



    Navigator.pop(context);

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.note == null ? "New Note" : "Edit Note"),

        actions: [

          IconButton(

            icon: const Icon(Icons.save),

            onPressed: _saveNote,

          ),

        ],

      ),

      body: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          children: [

            TextField(

              controller: _titleController,

              decoration: const InputDecoration(

                hintText: "Title",

                border: InputBorder.none,

                // fontSize: 20,

              ),

            ),

            Expanded(

              child: TextField(

                controller: _contentController,

                decoration: const InputDecoration(

                  hintText: "Write your note here...",

                  border: InputBorder.none,

                ),

                maxLines: null,

                keyboardType: TextInputType.multiline,

              ),

            ),

            if (_image != null)

              Image.file(

                _image!,

                height: 200,

                width: double.infinity,

                fit: BoxFit.cover,

              ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                IconButton(

                  icon: const Icon(Icons.image),

                  onPressed: _pickImage,

                ),

              ],

            ),

          ],

        ),

      ),

    );

  }

}
