import 'package:new_todo/import.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController TargetController = TextEditingController(text: "0");

  var formKey = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }
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
              Label: 'Client name  ',
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter task description';
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              Label: "التحصيل",
              controller: TargetController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Report';
                }
                return null;
              },
            ),
            CustomTextFormField(
              lines: 2,
              Label: 'Notes ',
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
                    'Add ',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void addTask() async {
    double DTarget = double.parse(TargetController.text);

    if (formKey.currentState?.validate() == false) {
      return;
    }
    Task task = Task(
      dateTime: MyDateUtils.dateOnly(selectedDate),
      desc: descriptionController.text,
      title: titleController.text,
    );

    appProvider authProvider = Provider.of<appProvider>(context, listen: false);
    authProvider.updateTask(task);
    await MyDataBase.addTask(
        user?.uid?? "",
        task);
    Target target = Target(
      DailyTarget:DTarget,
    );
    await MyDataBase.addTarget(
      user?.uid?? "",
      target,
    );
    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Task Add Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  var selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (date == null) return;
    setState(() {
      selectedDate = date;
    });
  }
}