import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_todo/ui/database/model/user_model.dart';

class MyDataBase {

  static addUser(User user) {
    var db = FirebaseFirestore.instance;
    var collection = db.collection("users").withConverter<User>(
        fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
        toFirestore:(user, options) => user.toFireStore(),
    );
  }
}