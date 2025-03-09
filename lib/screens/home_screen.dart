import 'package:flutter/material.dart';

import 'package:provider/provider.dart'; // Add this import

import '../providers/note_provider.dart';

import '../models/note.dart';

import 'note_editor.dart';

import '../widgets/note_card.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key}); // Add this



  @override

  _HomeScreenState createState() => _HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen> {

  @override

  void initState() {

    super.initState();

    loadNotes();

  }



  void loadNotes() async {

    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    await noteProvider.loadNotes();

    setState(() {});

  }



  void deleteNote(int id) async {

    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    await noteProvider.deleteNote(id);

    loadNotes();

  }



  @override

  Widget build(BuildContext context) {

    final noteProvider = Provider.of<NoteProvider>(context);

    final notes = noteProvider.notes;



    return Scaffold(

      appBar: AppBar(title: const Text("My Notes")),

      body: notes.isEmpty

          ? const Center(child: Text("No notes available"))

          : ListView.builder(

              itemCount: notes.length,

              itemBuilder: (context, index) {

                return NoteCard(

                  note: notes[index],

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) => NoteEditor(note: notes[index]),

                      ),

                    ).then((_) => loadNotes());

                  },

                  onDelete: () => deleteNote(notes[index].id!),

                );

              },

            ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(builder: (context) => const NoteEditor()),

          ).then((_) => loadNotes());

        },

        child: const Icon(Icons.add),

      ),

    );

  }

}
