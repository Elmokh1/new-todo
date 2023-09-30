import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:new_todo/ui/componant/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import '../../../database/model/task_model.dart';
import '../../../database/my_database.dart';

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
  @override
  void initState() {
    super.initState();
    askUserForPermissionAndService();
  }
  askUserForPermissionAndService()async{
   await requestPermission();
   await requestService();
    getUserLocation();
  }
  @override

  Widget build(BuildContext context) {
    TextEditingController ReportController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var authProvider = Provider.of<AuthProvider>(context);

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
              lines: 10,
              Label: "Report",
              controller: ReportController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter Report';
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (formKey.currentState?.validate() == false) {
                      return;
                    }
                    addReport();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40,top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 300,
                      height: 100,
                      child: Center(child: Text("Add",style: GoogleFonts.poppins(fontSize: 40),)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
  void doneTask(String taskId) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String currentUserId = authProvider.currentUser?.id ?? "";
    setState(() {
      widget.task.isDone = true;
      print("isDone: ${widget.task.isDone}");
    });
    MyDataBase.editTask(currentUserId, taskId, true);
  }
  void addReport() {
    getUserLocation();
  }
  void  getUserLocation ()async{
    var canGetLocation = await canUseGps();

    if(!canGetLocation){
      return;
    }
    var locationData = await locationManger.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
  }
  Future<bool>isLocationServiceEnabled()async{
    return await locationManger.serviceEnabled();
  }
  Future<bool>requestService()async{
    var enabled =  await locationManger.requestService();
    return enabled;
  }
  Future<bool> isPermissionGranted () async{
    var permissionStatus= await locationManger.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }
  Future<bool> requestPermission()async{
    var permissionStatus= await locationManger.requestPermission();
    return permissionStatus == PermissionStatus. granted;

  }
  Future<bool> canUseGps()async{
    var permissionGranted =await isPermissionGranted () ;
    if(!permissionGranted){
      return false;
    }
    var isServiceEnabled = await isLocationServiceEnabled() ;
    if(!isServiceEnabled){
      return false;
    }
    return true;
  }


}



