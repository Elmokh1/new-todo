import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_todo/admin_screen/sales/order_item.dart';
import 'package:new_todo/database/model/Order_Model.dart';
import 'package:new_todo/ui/UserMap/user_map.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../MyDateUtils.dart';
import '../../database/model/income_model.dart';
import '../../database/model/target_model.dart';
import '../../database/model/task_model.dart';
import '../../database/model/user_model.dart';
import '../../database/my_database.dart';
import '../../map/map.dart';
import '../../provider/Auth_provider.dart';
import '../../ui/HomeScreen/todos_list/task_item.dart';

class SalesScreen extends StatefulWidget {
  static const String routeName = "SalesScreen";

  final User? user;

  SalesScreen({this.user});

  @override
  State<SalesScreen> createState() => _NotDoneState();
}

class _NotDoneState extends State<SalesScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  Set<Marker> markerSet = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: focusedDate,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onFormatChanged: (format) => null,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDate = selectedDay;
                this.focusedDate = focusedDay;
                print(selectedDay);
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot<OrderModel>>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null) {
                    return Text("Data is null");
                  }
                  var OrdersList =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();
                  print("OrdersList: $OrdersList"); // Add this line to debug
                  if (OrdersList.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders available",
                        style: GoogleFonts.abel(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final order = OrdersList[index];
                      // if (order.accept == true){
                      //   return SizedBox.shrink();
                      // }
                      return OrderItem(orderModel: order,userId: widget.user?.id ?? "",);
                    },
                    itemCount: OrdersList.length,
                  );
                },
                stream: MyDataBase.getOrderRealTimeUpdate(
                  widget.user?.id ?? "",
                  MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
