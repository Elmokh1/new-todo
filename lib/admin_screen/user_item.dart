import 'package:flutter/material.dart';
import 'package:new_todo/admin_screen/user_information.dart';
import 'package:new_todo/database/model/user_model.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  User user;

  UserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserInformation(user),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          width: 100,
          height: 100,
          child: Center(child: Text(user.name ?? "")),
        ),
      ),
    );
  }
}
