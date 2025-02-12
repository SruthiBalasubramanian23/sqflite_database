import 'package:flutter/material.dart';
import 'package:sqflite_example/functions/db_functions.dart';
import 'package:sqflite_example/model/data_model.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> studentList,
          Widget? child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final data = studentList[index];
              return ListTile(
                title: Text(data.name),
                subtitle: Text(data.age),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await deleteStudent(data.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            _editStudent(context, data);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: studentList.length);
      },
    );
  }

  void _editStudent(BuildContext context, StudentModel student) {
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Edit Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Age"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final updatedStudent = StudentModel(
                  id: student.id,
                  name: nameController.text,
                  age: ageController.text,
                );
                updateStudent(updatedStudent);
                Navigator.of(ctx).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
