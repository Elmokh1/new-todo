import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_todo/database/model/report_model.dart';

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
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static CollectionReference<Report> getReportCollection(String uid, String tId) {
    return getTaskCollection(uid)
        .doc(tId)
        .collection(Report.collectionName)
        .withConverter<Report>(
      fromFirestore: (snapshot, options) =>
          Report.fromFireStore(snapshot.data()),
      toFirestore: (report, options) => report.toFireStore(),
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

  static Future<void> addReport(String uid, String tId, Report report) {
    var newReport = getReportCollection(uid, tId).doc();
    report.id = newReport.id;
    return newReport.set(report);
  }

  static Future<QuerySnapshot<Task>> getTasks(String uId) {
    return getTaskCollection(uId).get();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdate(String uId, int date) {
    return getTaskCollection(uId)
        .where("dateTime", isEqualTo: date)
        .snapshots();
  }
  static Stream<QuerySnapshot<User>> getUserRealTimeUpdate() {
    return getUserCollection().snapshots();
  }
  static Stream<QuerySnapshot<Report>> getReportRealTimeUpdate(String uid,String tId) {
    return getReportCollection(uid, tId).snapshots();
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
