import 'package:new_todo/import.dart';

class ReportModal extends StatefulWidget {
  Task task;

  ReportModal({
    required this.task,
  });

  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  var locationManger = Location();
  var formKey = GlobalKey<FormState>();
  TextEditingController ReportController = TextEditingController();
  TextEditingController IncomeController = TextEditingController(text: "0");
  var auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    askUserForPermissionAndService();
  }


  askUserForPermissionAndService() async {
    await requestPermission();
    await requestService();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Report',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              Label: "التحصيل",
              controller: IncomeController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Report';
                }
                return null;
              },
            ),
            CustomTextFormField(
              lines: 5,
              Label: "Report",
              controller: ReportController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Report';
                }
                return null;
              },
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: InkWell(
                onTap: () {
                  if (formKey.currentState?.validate() == false) {
                    return;
                  }
                  addReport();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: 300,
                    height: 100,
                    child: Center(
                      child: Text(
                        "Add",
                        style: GoogleFonts.poppins(fontSize: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();

  void drawUserMarker() async {
    var canGetLocation = await canUseGps();
    if (!canGetLocation) return;
    var locationData = await locationManger.getLocation();
  }

  Future<LocationData?> getUserLocation() async {
    var canGetLocation = await canUseGps();

    if (!canGetLocation) {
      return null;
    }
    var locationData = await locationManger.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    return null;
  }

  Future<bool> isLocationServiceEnabled() async {
    return await locationManger.serviceEnabled();
  }

  Future<bool> requestService() async {
    var enabled = await locationManger.requestService();
    return enabled;
  }

  Future<bool> isPermissionGranted() async {
    var permissionStatus = await locationManger.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> requestPermission() async {
    var permissionStatus = await locationManger.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> canUseGps() async {
    var permissionGranted = await isPermissionGranted();
    if (!permissionGranted) {
      return false;
    }
    var isServiceEnabled = await isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return false;
    }
    return true;
  }

  void addReport() async {
    double Dincome = double.parse(IncomeController.text);

    var locationData = await locationManger.getLocation();
    Report report = Report(
      long: locationData.longitude ?? 0.0,
      lat: locationData.latitude ?? 0.0,
      report: ReportController.text,
      dateTime: selectedDate,
    );

    appProvider reportProvider =
        Provider.of<appProvider>(context, listen: false);
    var taskId = await reportProvider.currentTask?.id;
    var userId = await reportProvider.currentUser?.id;
    print(taskId);
    await MyDataBase.addReport(
      user?.uid ?? "",
      widget.task.id ?? "",
      report,
    );
    Income income = Income(
      DailyInCome: Dincome,
    );
    await MyDataBase.addIncome(
      user?.uid ?? "",
      income,
    );
    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Report Add Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    var authProvider = Provider.of<appProvider>(context, listen: false);
    authProvider.updateReport(report);

  }
}
