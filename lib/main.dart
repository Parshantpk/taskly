import 'package:flutter/material.dart';
import 'package:taskly/add_task.dart';
import 'home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
void main() async {
  await Hive.initFlutter('hive_boxes');
  box = await Hive.openBox('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => AddTask(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

