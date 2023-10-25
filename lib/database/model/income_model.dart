
class Income {
  static const String collectionName = 'income';
  String? id;
  double? DailyInCome;

  Income({
    this.DailyInCome,
    this.id
  });

  Income.fromFireStore(Map<String, dynamic>? date)
      : this(
    id: date?["id"],
    DailyInCome: date?["DailyInCome"],
  );

  Map<String, dynamic>toFireStore() {
    return {
      "id": id,
      "DailyInCome": DailyInCome,
    };
  }
}
