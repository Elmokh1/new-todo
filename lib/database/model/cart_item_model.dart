class CartItemsModel {
  static const String collectionName = 'CartItems';
  String? id;
  String? product;
  int? price;
  int? quantity;

  CartItemsModel({this.id, this.product, this.price, this.quantity});

  factory CartItemsModel.fromFirestore(Map<String, dynamic> data) {
    return CartItemsModel(
      id: data['id'],
      product: data['product'],
      price: data['price'],
      quantity: data['quantity'],
    );
  }
  Map<String, dynamic> toFireStore() {
    return {'id': id, 'product': product, 'price': price, 'quantity': quantity};
  }
}
