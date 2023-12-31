import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String Label;
  TextEditingController controller;
  MyValidator validator;
  bool isPassword;
  int lines ;

  CustomTextFormField(
      {required this.Label,
      this.isPassword = false,
      required this.controller,
      required this.validator,
         this.lines=1,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20.0,top: 15,),
      child: TextFormField(
        maxLines: lines,
        minLines: lines,
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          label: Text("$Label"),
        ),
      ),
    );
  }
}
