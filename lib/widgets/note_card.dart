import 'package:flutter/material.dart';

import '../models/note.dart';

import 'dart:io';



class NoteCard extends StatelessWidget {

  final Note note;

  final VoidCallback onTap;

  final VoidCallback onDelete;



  const NoteCard({super.key, required this.note, required this.onTap, required this.onDelete}); // Add this



  @override

  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Card(

        child: Padding(

          padding: const EdgeInsets.all(8.0),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Text(

                    note.title,

                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                  ),

                  IconButton(

                    icon: const Icon(Icons.delete),

                    onPressed: onDelete,

                  ),

                ],

              ),

              const SizedBox(height: 4),

              if (note.imagePath != null)

                Image.file(

                  File(note.imagePath!),

                  height: 150,

                  width: double.infinity,

                  fit: BoxFit.cover,

                ),

              const SizedBox(height: 4),

              Text(

                note.content,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

              ),

            ],

          ),

        ),

      ),

    );

  }

}


