import 'package:firebase_auth/firebase_auth.dart';

class Report {
  static const String collectionName = 'Report';
  String? id;
  String? report;
  double? lat;
  double? long;
  DateTime? dateTime;

  Report({
    this.id,
    this.report,
    this.lat,
    this.long,
    this.dateTime,
  });

  Report.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          report: data?['report'],
          lat: data?['lat'],
          long: data?['long'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data?["dateTime"]),
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'report': report,
      'lat': lat,
      'long': long,
      "dateTime": dateTime?.millisecondsSinceEpoch,
    };
  }
}
