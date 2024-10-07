import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/Cubit/note_cubit.dart';
import 'package:note/Hive/Hive_Helper.dart';
import 'package:note/NoteApp.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.noteBox);

  runApp(
    const MyApp(), // Use a stateless widget to wrap the MaterialApp
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NoteCubit()..getNotes(), // Provide NoteCubit instead of NoteApp
      child: const MaterialApp(
        home: NoteApp(),
        debugShowCheckedModeBanner: false, // Hide the debug banner
      ),
    );
  }
}
