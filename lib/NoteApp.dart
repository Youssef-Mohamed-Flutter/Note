import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/Cubit/note_cubit.dart';
import 'package:note/Hive/Hive_Helper.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFF120311),
      appBar: AppBar(
        centerTitle: true, // This centers the title
        actions: [
          InkWell(
            onTap: () {
              cubit.removeAllNotes();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.playlist_remove_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF120311),
        title: const Text(
          "Note App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNoteDialog(context, cubit);
        },
        backgroundColor: Colors.pink, // Custom color for the button
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: HiveHelper.myNotes.length,
            itemBuilder: (context, index) => Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showUpdateNoteDialog(
                        context, index, cubit); // Show dialog to update note
                  },
                  child: noteContainer(index),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: InkWell(
                    onTap: () {
                      cubit.removeNotes(index);
                    },
                    child: const Icon(
                      Icons.playlist_remove_sharp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method to show the dialog for adding a new note
  void showAddNoteDialog(BuildContext context, NoteCubit cubit) {
    TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF120311),
          title: const Text(
            'Add New Note',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: noteController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter your note',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                cubit.addNotes(noteController.text);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to show the dialog for updating an existing note
  void showUpdateNoteDialog(BuildContext context, int index, NoteCubit cubit) {
    TextEditingController noteController = TextEditingController();
    noteController.text = HiveHelper
        .myNotes[index]; // Pre-fill the controller with the current note

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF120311),
          title: const Text(
            'Update Note',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: noteController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Edit your note',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                cubit.updateNotes(text: noteController.text, index: index);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  Padding noteContainer(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF2D6F1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            HiveHelper.myNotes[index],
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
