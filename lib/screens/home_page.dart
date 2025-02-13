import 'package:flutter/material.dart';
import 'package:sqflite_example/functions/db_functions.dart';
import 'package:sqflite_example/model/data_model.dart';
import 'package:sqflite_example/screens/widgets/add_student_widget.dart';
import 'package:sqflite_example/screens/widgets/list_student_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

SaveButtonMode saveButtonMode = SaveButtonMode.save;
int? indexToUpdate;

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController nameController;
  late final TextEditingController ageController;
  late final FocusNode nameFocusNode;
  late final FocusNode ageFocusNode;

  final ValueNotifier<SaveButtonMode> saveButtonMode =
      ValueNotifier(SaveButtonMode.save);

  final ValueNotifier<int?> indexToUpdate = ValueNotifier(null);

  @override
  void initState() {
    nameController = TextEditingController();
    ageController = TextEditingController();
    nameFocusNode = FocusNode();
    ageFocusNode = FocusNode();
    getAllStudents();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    nameFocusNode.dispose();
    ageFocusNode.dispose();

    super.dispose();
  }

  void bringPersonToUpdate(StudentModel studentModel, int index) async {
    nameController.text = studentModel.name;
    ageController.text = studentModel.age.toString();
    indexToUpdate.value = studentModel.id;
    saveButtonMode.value = SaveButtonMode.edit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AddStudentWidget(
              nameController: nameController,
              ageController: ageController,
              nameFocusNode: nameFocusNode,
              ageFocusNode: ageFocusNode,
              saveButtonMode: saveButtonMode,
              indexToUpdate: indexToUpdate),
          Expanded(
              child: ListStudentWidget(
            callback: bringPersonToUpdate,
          )),
        ],
      )),
    );
  }
}

enum SaveButtonMode { save, edit }
