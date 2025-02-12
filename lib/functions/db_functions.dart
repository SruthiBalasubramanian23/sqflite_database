// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_example/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT,age TEXT )');
  });
}

Future<void> getAllStudents() async {
  final List<Map<String, dynamic>> students = await _db.query('student');
  
  // Convert database data to StudentModel list
  studentListNotifier.value =
      students.map((e) => StudentModel.fromMap(e)).toList();
  
  log("Updated student list: ${studentListNotifier.value.toString()}"); // Debug log

  // Notify UI to refresh
  studentListNotifier.notifyListeners();
}


Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student (name,age) VALUES (?,?)', [value.name, value.age]);
  studentListNotifier.notifyListeners();
  getAllStudents();
  log(value.toString());
}

Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id =?', [id]);
  getAllStudents();
}

Future<void> updateStudent(StudentModel updatedStudent) async {
  await _db.rawUpdate('UPDATE student SET name = ?, age = ? WHERE id =?',
      [updatedStudent.name, updatedStudent.age, updatedStudent.id]);
  getAllStudents();
  log("Student updated: ${updatedStudent.toString()}");
}
