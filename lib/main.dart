import 'package:flutter/material.dart';
import 'package:my_notepad/Models/note_model.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:my_notepad/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  // await Hive.deleteBoxFromDisk('notes');

  await Hive.openBox("notes");
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),


    );
  }
}
