import 'package:flutter/material.dart';
import 'package:sqflite_example/functions/db_functions.dart';
import 'package:sqflite_example/model/data_model.dart';

class ListStudentWidget extends StatelessWidget {
  final void Function(StudentModel studentModel, int index) callback;
  const ListStudentWidget({super.key, required this.callback});

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
                subtitle: Text(data.age.toString()),
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
                            callback(data, index);
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
}
