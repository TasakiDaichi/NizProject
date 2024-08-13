import 'package:flutter/material.dart';
import 'todo_view.dart'; // todo_view.dart が TodoListPage を含んでいる
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Key を追加

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const TodoListPage(),
    );
  }
}
