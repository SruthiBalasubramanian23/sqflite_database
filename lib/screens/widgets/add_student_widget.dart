import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_example/functions/db_functions.dart';
import 'package:sqflite_example/model/data_model.dart';
import 'package:sqflite_example/screens/home_page.dart';

class AddStudentWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final FocusNode nameFocusNode;
  final FocusNode ageFocusNode;
  final ValueNotifier<SaveButtonMode> saveButtonMode;
  final ValueNotifier<int?> indexToUpdate;
  const AddStudentWidget(
      {super.key,
      required this.nameController,
      required this.ageController,
      required this.nameFocusNode,
      required this.ageFocusNode,
      required this.saveButtonMode,
      required this.indexToUpdate});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  void _unFocusAllFocusNode() {
    widget.nameFocusNode.unfocus();
    widget.ageFocusNode.unfocus();
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            controller: widget.nameController,
            focusNode: widget.nameFocusNode,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.ageController,
            focusNode: widget.ageFocusNode,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Age'),
          ),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder<SaveButtonMode>(
            valueListenable: widget.saveButtonMode,
            builder: (context, mode, _) {
              return ElevatedButton(
                  onPressed: () async{
                    final name = widget.nameController.text.trim();
                    final ageText = widget.ageController.text.trim();

                    if (name.isEmpty || ageText.isEmpty) {
                      _showSnackbar(context, "Please enter all details");
                      return;
                    }

                    final student = StudentModel(name: name, age: ageText);
                    if (mode == SaveButtonMode.save) {
                     await  addStudent(student);
                    } else {
                      updateStudent(widget.indexToUpdate.value!,student);
                      widget.saveButtonMode.value = SaveButtonMode.save;
                      widget.indexToUpdate.value = null;
                    }

                    widget.nameController.clear();
                    widget.ageController.clear();
                    
                    _unFocusAllFocusNode();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mode == SaveButtonMode.save
                          ? Colors.green
                          : Colors.blue,
                      foregroundColor: Colors.white),
                  child: Text(mode == SaveButtonMode.save ? "Save" : "Update"));
            },
          )
        ],
      ),
    );
  }
}
