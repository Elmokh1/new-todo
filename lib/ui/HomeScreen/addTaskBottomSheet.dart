import 'package:flutter/material.dart';
import 'package:new_todo/MyDateUtils.dart';
import 'package:new_todo/dialog_utils.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:new_todo/ui/componant/custom_text_field.dart';
import 'package:provider/provider.dart';


import '../../database/model/task_model.dart';
import '../../database/my_database.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Add Task',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            CustomTextFormField(
              Label: 'Enter Your Task ',
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter task description';
                }
              },
            ),
            CustomTextFormField(
              lines: 5,
              Label: 'Enter Your Description ',
              controller: descriptionController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter task description';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 5,
                bottom: 5,
              ),
              child: Text(
                "Selected time",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Text(
                  "${MyDateUtils.formatTaskDate(selectedDate)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16)),
                  onPressed: () {
                    addTask();
                  },
                  child: const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void addTask() async{

    if (formKey.currentState?.validate() == false) {
      return;
    }
    Task task = Task(
      dateTime: MyDateUtils.dateOnly(selectedDate),
      desc: descriptionController.text,
      title: titleController.text,
    );
    AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);
    await MyDataBase.addTask(authProvider.currentUser!.id ??"", task);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, "Task Added Successfully");
    DialogUtils.hideDialog(context);

  }
  var selectedDate = DateTime.now();
  void showTaskDatePicker() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );

    if (date == null) return;
    selectedDate = date;
    setState(() {});
  }
}
