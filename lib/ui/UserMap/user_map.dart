
import 'package:new_todo/database/model/user_model.dart'as MyUser;
import 'package:new_todo/import.dart';
import 'package:intl/intl.dart';

class MapTRACKUser extends StatefulWidget {
  static const String routeName = "Map";
  final Task? task;
  final MyUser.User? user;

  MapTRACKUser({this.task, this.user});

  @override
  State<MapTRACKUser> createState() => _MapTRACKState();
}

class _MapTRACKState extends State<MapTRACKUser> {
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
                    child: Column(
                      children: [
                        Text(
                          DateFormat('HH:mm:ss')
                              .format(report?[0].dateTime ?? DateTime.now()),
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            report?[0].report ?? "",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
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
                // markerSet;
              });
            },
            child: Text("Location"),
          ),
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
