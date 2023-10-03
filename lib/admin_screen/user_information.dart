import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_todo/admin_screen/admin_screen.dart';
import 'package:new_todo/admin_screen/tabs/done.dart';
import 'package:new_todo/admin_screen/tabs/notDone.dart';
import 'package:new_todo/database/model/task_model.dart';
import 'package:new_todo/database/model/user_model.dart' as MyUser;

import '../ui/HomeScreen/settings/settings.dart';
import '../ui/HomeScreen/todos_list/todos_list.dart';

class UserInformation extends StatefulWidget {

  MyUser.User user;
  UserInformation(this.user);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tabs = [
      NotDone(widget.user),
      ReportDone(widget.user),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pushNamed(context,AdminScreen.routeName);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 32,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle,
                  size: 32,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }


}
