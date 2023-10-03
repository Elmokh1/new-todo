import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_todo/database/model/user_model.dart';
import 'package:new_todo/map/map.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../MyDateUtils.dart';
import '../../database/model/task_model.dart';
import '../../database/my_database.dart';
import '../../provider/Auth_provider.dart';
import '../../ui/HomeScreen/todos_list/task_item.dart';

class ReportDone extends StatefulWidget {
  User user;

  ReportDone(this.user);

  @override
  State<ReportDone> createState() => _NotDoneState();
}

class _NotDoneState extends State<ReportDone> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  Set<Marker> markerSet = {}; // Added 'markerSet' field

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<appProvider>(context);
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
                    if (task.isDone == false) {
                      return SizedBox.shrink();
                    } else {
                      return InkWell(
                        child: TaskItem(task:task),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapTRACK(
                                task: task,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      );
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
          ),
        ],
      ),
    );
  }
}