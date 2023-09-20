
import 'package:flutter/cupertino.dart';

import '../database/model/user_model.dart';

class AuthProvider extends ChangeNotifier{
  User? currentUser;
  void updateUSer (User loggedIn) {
    currentUser = loggedIn;
    notifyListeners();
  }
}