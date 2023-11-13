import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_todo/database/model/cart_item_model.dart';

class OrderModel {
  static const String collectionName = 'order';

  String? id;
  String? customerName;
  List? cartItems;
  DateTime? dateTime;
  int? totalPrice;
  bool accept;

  OrderModel({
    this.id,
    this.customerName,
    this.cartItems,
    this.dateTime,
    this.totalPrice,
    this.accept = false,
  });

  OrderModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?["id"],
          customerName: data?["customerName"],
          cartItems: (data?["cartItems"] as List<dynamic>)
              .map((item) => CartItemsModel.fromFirestore(item))
              .toList(),
          dateTime: DateTime.fromMillisecondsSinceEpoch(data?["dateTime"]),
          totalPrice: data?['totalPrice'],
          accept: data?['accept'],
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'customerName': customerName,
      'cartItems': cartItems?.map((item) => item.toFireStore()).toList(),
      "dateTime": dateTime?.millisecondsSinceEpoch,
      'totalPrice': totalPrice,
      'accept' :accept,
    };
  }
}
