import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_todo/database/model/task_model.dart';
import 'package:new_todo/database/my_database.dart';
import 'package:new_todo/dialog_utils.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: Colors.red,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteTask();
              },
              icon: Icons.delete,
              label: "Delete",
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14.0),
                bottomLeft: Radius.circular(14.0),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 80,
                width: 3,
                color: theme.primaryColor,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.task.title}",
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "${widget.task.desc}",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 7.0),
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Image.asset("assets/images/Ic_check.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(
      context,
      "are you sure",
      posActionName: "yes",
      negActionName: "Cancel",
      posAction: deletTaskFromDataBase,



    );
  }
  void deletTaskFromDataBase()async{
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    try{
      await MyDataBase.deleteTask(authProvider.currentUser?.id ?? "", widget.task.id ?? "");
      Fluttertoast.showToast(
          msg: "Task deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } catch (e){
      DialogUtils.showMessage(context, "Somthing went wrong");
    }

  }
}
