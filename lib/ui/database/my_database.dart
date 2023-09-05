import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_todo/ui/database/model/user_model.dart';

class MyDataBase {
  static CollectionReference<User> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(User.collectionName)
        .withConverter<User>(
          fromFirestore: (snapshot, options) =>
              User.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUser(User user) {
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }

  static Future<User?>readUser(String id) async{
    var collection = getUserCollection();
    var docSnapShot =  await collection.doc(id).get();
    return docSnapShot.data();

  }
}
