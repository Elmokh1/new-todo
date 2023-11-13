import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../MyDateUtils.dart';
import '../../database/model/task_model.dart';
import '../../database/model/user_model.dart';
import '../../database/my_database.dart';
import '../../ui/HomeScreen/todos_list/task_item.dart';

class NotDone extends StatefulWidget {
  User user;

  NotDone(this.user);

  @override
  State<NotDone> createState() => _NotDoneState();
}

class _NotDoneState extends State<NotDone> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onFormatChanged: (format) => null,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDate = selectedDay;
                this.focusedDate = focusedDay;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var taskList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (taskList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "!! فاضي ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final task = taskList![index];
                    if (task.isDone == true) {
                      return SizedBox
                          .shrink(); // إخفاء العنصر إذا كانت isDone = true
                    } else {
                      return TaskItem(task: task);
                    }
                  },
                  itemCount: taskList?.length ?? 0,
                );
              },
              stream: MyDataBase.getTasksRealTimeUpdate(
                widget.user.id ?? "",
                MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
              ),
            ),
          )
        ],
      ),
    );
  }
}
