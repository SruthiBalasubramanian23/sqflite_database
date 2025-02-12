import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_example/functions/db_functions.dart';
import 'package:sqflite_example/model/data_model.dart';

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key});

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Age'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {

              onAddStudentButtonClicked();
               },
            label: const Text('Add Student'),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    if (name.isEmpty || age.isEmpty) {
      return;
    }
    log("$name,$age");

    final student = StudentModel(name: name, age: age);
    addStudent(student);

    _nameController.clear();
    _ageController.clear();
  }
}
