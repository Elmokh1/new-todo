import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_todo/dialog_utils.dart';
import 'package:new_todo/ui/HomeScreen/home_screen.dart';
import 'package:new_todo/ui/componant/custom_text_field.dart';
import 'package:new_todo/ui/database/model/user_model.dart' as MyUser;
import 'package:new_todo/ui/database/my_database.dart';
import 'package:new_todo/ui/login/login_screen.dart';
import '../../validation_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "ahmedMokhtar");
  var emailController = TextEditingController(text: "elmokh843@gmail.com");
  var passwordController = TextEditingController(text: "123456");
  var passwordConfirmationController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
            image: AssetImage('assets/images/auth_pattern.png'),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Welcome back!",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter full Name ';
                      }
                    },

                    Label: "First name",
                    // controller: nameController,
                    // validator: validator,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    Label: "E mail",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Email ';
                      }
                      if (!ValidationUtils.isValidEmail(text)) {
                        return 'Please Enter a Valid Email';
                      }
                    },
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    controller: passwordController,
                    Label: "Password",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter The Password ';
                      }
                      if (text.length < 6) {
                        return "Password Must be 6 char";
                      }
                    },
                  ),
                  CustomTextFormField(
                    isPassword: true,
                    controller: passwordConfirmationController,
                    Label: "Password Confirmation",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Password Confirmation ';
                      }
                      if (passwordController.text != text) {
                        return "password doesn't match";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30, right: 30, bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        register();
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: const Text("Already Have Account")),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Register'),
          )),
    );
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void register() async {
    // async - await
    if (formkey.currentState?.validate() == false) {
      return;
    }

    DialogUtils.showLoadingDialog(context, 'Loading...');
    try {
      var result = await authService.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var myUser = MyUser.User(
        name: nameController.text,
        email: emailController.text,
        id: result.user?.uid,
      );
      await MyDataBase.addUser(myUser);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        "User Register Successfully",
        postActionName: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        dismissible: false,
      );

      // DialogUtils.hideDialog(context);
      // DialogUtils.showMessage(context, 'user registered successfully',
      //     postActionName: 'ok', posAction: () {
      //   Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      // }, dismissible: false);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context, errorMessage, postActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
          postActionName: 'cancel', negActionName: 'Try Again', negAction: () {
        register();
      });
    }
  }
}
