import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_todo/database/model/report_model.dart';
import 'package:new_todo/database/model/user_model.dart';
import 'package:new_todo/database/my_database.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:provider/provider.dart';

import '../database/model/task_model.dart';
import '../dialog_utils.dart';

class MapTRACK extends StatefulWidget {
  static const String routeName = "Map";
  final Task? task;
  final User? user;

  MapTRACK({this.task, this.user});

  @override
  State<MapTRACK> createState() => _MapTRACKState();
}

class _MapTRACKState extends State<MapTRACK> {
  late CameraPosition Agrihawk;
  late Set<Marker> markerSet = {};

  @override
  void initState() {
    super.initState();
    Agrihawk = CameraPosition(
      target: LatLng(
        30.5976925,
        31.4894909,
      ),
      zoom: 2,
    );
  }

  static const String userMarker = "user";

  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<appProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: StreamBuilder<QuerySnapshot<Report>>(
                builder: (context, snapshot) {
                  var report =
                      snapshot.data?.docs.map((doc) => doc.data()).toList();
                  double? lat = report?[0].lat;
                  double? long = report?[0].long;
                  print(lat);
                  print(long);
                  if (lat == 0.0 && long == 0.0) {
                    DialogUtils.showLoadingDialog(context, 'Loading...');
                  }
                  markerSet = {
                    Marker(
                      markerId: MarkerId('UserLocation'),
                      position: LatLng(lat ?? 0.0, long ?? 0.0),
                    ),
                  };
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Text(
                        report?[0].report ?? "",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  );
                },
                stream: MyDataBase.getReportRealTimeUpdate(
                  widget.user?.id ?? "",
                  widget.task?.id ?? "",
                ),
              )),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  markerSet;
                });
              },
              child: Text("Location")),
          Expanded(
            flex: 3,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: Agrihawk,
              markers: markerSet,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _controller = controller;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
