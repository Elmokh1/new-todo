import 'package:firebase_auth/firebase_auth.dart';

class Report {
  // data class
  static const String collectionName = 'Report';
  String? id;
  String? report;
  double? lat;
  double? long;

  Report({this.id, this.report, this.lat,this.long});

  Report.fromFireStore(Map<String, dynamic>? data)
      : this(id: data?['id'], report: data?['report'], lat: data?['lat'],long: data?['long']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'report': report, 'lat': lat, 'long' :long};
  }
}
