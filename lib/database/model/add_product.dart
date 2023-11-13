import 'dart:ffi';

class AddProductModel {
  // data class
  static const String collectionName = 'Products';
  String? id;
  String? product;
  int? price;
  String? des;

  AddProductModel({this.id, this.product, this.price, this.des});

  AddProductModel.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'],
            product: data?['product'],
            price: data?['price'],
            des: data?['des']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'product': product,
      'price': price,
      'des': des,
    };
  }
}
