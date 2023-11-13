import 'package:new_todo/import.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
      children: [
        Text(
          "Welcome Back ",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.blue,
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
              var taskList = snapshot.data?.docs.map((doc) => doc.data()).toList();
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
                  if (task.isDone ==true) {
                    return SizedBox.shrink(); // إخفاء العنصر إذا كانت isDone = true
                  } else {
                    return TaskItem(task: task);
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
        ),
      ],
    );
  }
}
