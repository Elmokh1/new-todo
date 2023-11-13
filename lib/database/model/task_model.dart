class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? desc;
  DateTime? dateTime;
  bool isDone;

  Task({
    this.id,
    this.title,
    this.desc,
    this.dateTime,
    this.isDone = false,
  });

  Task.fromFireStore(Map<String, dynamic>? date)
      : this(
          id: date?["id"],
          title: date?["title"],
          desc: date?["desc"],
          dateTime: DateTime.fromMillisecondsSinceEpoch(date?["dateTime"]),
          isDone: date?["isDone"],
        );

  Map<String,dynamic>toFireStore() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "dateTime": dateTime?.millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}
