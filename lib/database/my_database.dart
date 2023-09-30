import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/task_model.dart';
import 'model/user_model.dart';

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

  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addUser(User user) {
    var collection = getUserCollection();
    return collection.doc(user.id).set(user);
  }

  static Future<User?> readUser(String id) async {
    var collection = getUserCollection();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
  }

  static Future<void> addTask(String uid, Task task) {
    var newTask = getTaskCollection(uid).doc();
    task.id = newTask.id;
    return newTask.set(task);
  }

  static Future<QuerySnapshot<Task>> getTasks(String uId) {
    return getTaskCollection(uId).get();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdate(
      String uId, int date) {
    return getTaskCollection(uId)
        .where("dateTime", isEqualTo: date)
        .snapshots();
  }

  static Future<void> deleteTask(String uId, String taskId) {
    return getTaskCollection(uId).doc(taskId).delete();
  }

  static Future<void> editTask(String uId, String taskId, bool isDone) {
    return getTaskCollection(uId).doc(taskId).update({
      "isDone": isDone,
    });
  }


}
