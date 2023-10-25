
class Target {
  static const String collectionName = 'target';
  String? id;
  double? DailyTarget;

  Target({
    this.DailyTarget,
    this.id
  });

  Target.fromFireStore(Map<String, dynamic>? date)
      : this(
    id: date?["id"],
    DailyTarget: date?["DailyTarget"],
  );

  Map<String, dynamic>toFireStore() {
    return {
      "id": id,
      "DailyTarget": DailyTarget,
    };
  }
}
