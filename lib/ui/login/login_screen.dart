import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_todo/dialog_utils.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:new_todo/ui/componant/custom_text_field.dart';
import 'package:new_todo/ui/register/register_screen.dart';
import 'package:provider/provider.dart';
import '../../database/my_database.dart';
import '../../validation_utils.dart';
import '../HomeScreen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: "ahmedMokhtar");

  var emailController = TextEditingController(text: "elmokh8433@gmail.com");

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
            key: formKey,
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Login();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: const Text("Don`t Have Account"))
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Login'),
          )),
    );
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void Login() async {
    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }

    DialogUtils.showLoadingDialog(context, 'Loading...');
    try {
      var result = await authService.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var user = await MyDataBase.readUser(result.user?.uid ?? "");
      if (user ==null){
        DialogUtils.showMessage(context, "Error to ind user in db", posActionName: 'ok');
        return;
      }
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(
        context,
        "User Logged in  Successfully",
        posActionName: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        dismissible: false,
      );
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      authProvider.updateUSer(user);

    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'wrong email or password';
      DialogUtils.showMessage(context, errorMessage, posActionName: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
          posActionName: 'cancel', negActionName: 'Try Again', negAction: () {
        Login();
      });
    }
  }
}
