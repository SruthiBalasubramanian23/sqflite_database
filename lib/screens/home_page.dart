import 'package:flutter/material.dart';
import 'package:sqflite_example/functions/db_functions.dart';
import 'package:sqflite_example/screens/widgets/add_student_widget.dart';
import 'package:sqflite_example/screens/widgets/list_student_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AddStudentWidget(),
          const Expanded(child: ListStudentWidget()),
        ],
      )),
    );
  }
}
