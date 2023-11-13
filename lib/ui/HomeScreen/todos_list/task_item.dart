import 'package:new_todo/import.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
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
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.red,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.task.isDone == false) {
                        widget.task.isDone = !widget.task.isDone;
                      }
                    });
                    MyDataBase.editTask(
                      user?.uid ?? "",
                      widget.task.id ?? "",
                      widget.task.isDone,
                    );
                    print(widget.task.isDone);
                    if (widget.task.isDone == true) {
                      showReportModal();
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 7.0),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: widget.task.isDone == false
                          ? Image.asset("assets/images/Ic_check.png")
                          : Icon(
                              Icons.not_interested_outlined,
                              color: Colors.red,
                            )),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.task.isDone == false
                      ? Text(
                          "${widget.task.title}",
                          style: TextStyle(
                            fontSize: 18,
                            color: widget.task.isDone == false
                                ? theme.primaryColor
                                : Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Text(
                          "${widget.task.title}",
                          style: TextStyle(
                            fontSize: 18,
                            color: widget.task.isDone == false
                                ? theme.primaryColor
                                : Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  widget.task.isDone == false
                      ? Text(
                          "${widget.task.desc}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : Text(
                          "${widget.task.desc}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                ],
              )),
              Container(
                margin: const EdgeInsets.all(20),
                height: 80,
                width: 3,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showReportModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ReportModal(
              task: widget.task,
            ),
          ),
        );
      },
    );
  }
}
