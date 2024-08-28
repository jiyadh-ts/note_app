import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/view/Screem_two/Screentwo.dart';
import 'package:note_app/view/Screen_one/screenone.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box=await Hive.openBox("noteBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screenone(),
    );
  }
}
