import 'package:new_todo/import.dart';

class Done extends StatefulWidget {
  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<appProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Center(
          child: Text(
            "Welcome Back }",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
        ),
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
        InkWell(
          onLongPress: () async {
            setState(() {});
            await MyDataBase.deleteTarget(user?.uid ?? "");
            await MyDataBase.deleteIncome(user?.uid ?? "");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot<Target>>(
                    builder: (context, targetSnapshot) {
                      if (targetSnapshot.hasError) {
                        return Container();
                      }
                      if (targetSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var targetList = targetSnapshot.data?.docs
                          .map((doc) => doc.data() as Target)
                          .toList();
                      double totalTarget = 0.0;
                      if (targetList != null && targetList.isNotEmpty) {
                        totalTarget = targetList
                            .map((target) => target.DailyTarget ?? 0)
                            .reduce((a, b) => a + b);
                      }

                      return StreamBuilder<QuerySnapshot<Income>>(
                        builder: (context, incomeSnapshot) {
                          if (incomeSnapshot.hasError) {
                            return Container();
                          }
                          if (incomeSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var incomeList = incomeSnapshot.data?.docs
                              .map((doc) => doc.data() as Income)
                              .toList();
                          double totalIncome = 0.0;
                          if (incomeList != null && incomeList.isNotEmpty) {
                            totalIncome = incomeList
                                .map((income) => income.DailyInCome ?? 0)
                                .reduce((a, b) => a + b);
                          }
                          double difference = totalTarget - totalIncome;
                          return Column(
                            children: [
                              Text(
                                'المستهدف: $totalTarget',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'التحصيل: $totalIncome',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'العجز : $difference',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          );
                        },
                        stream: MyDataBase.getIncomeRealTimeUpdate(
                          user?.uid ?? "",
                        ),
                      );
                    },
                    stream: MyDataBase.getTargetRealTimeUpdate(
                      user?.uid ?? "",
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    return InkWell(
                      child: TaskItem(task: task),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapTRACK(
                              task: task,
                              user: user,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
                itemCount: taskList?.length ?? 0,
              );
            },
            stream: MyDataBase.getTasksRealTimeUpdate(
              user?.uid ?? "",
              MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
            ),
          ),
        )
      ],
    );
  }
}
