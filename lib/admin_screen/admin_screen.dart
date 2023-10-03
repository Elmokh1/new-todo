import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_todo/admin_screen/user_item.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:new_todo/database/model/user_model.dart' as MyUser;

import '../database/my_database.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = "AdminScreen";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  MyUser.User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<MyUser.User>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var userList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (userList?.isEmpty == true) {
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
                    final user = userList![index];
                    return UserItem(user:user);
                  },
                  itemCount: userList?.length ?? 0,
                );
              },
              stream: MyDataBase.getUserRealTimeUpdate(),
            ),
          )
        ],
      ),
    );
  }
}
