import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_todo/database/model/cart_item_model.dart';
import 'package:new_todo/database/model/cart_item_model.dart';
import '../../database/model/Order_Model.dart';
import '../../database/model/cart_item_model.dart';
import '../../database/my_database.dart';
import '../../dialog_utils.dart';
import '../Product/added_product.dart';
import '../componant/custom_form_field.dart';

class CartPage extends StatefulWidget {
  final List<AddedProduct> addProduct;

  CartPage({required this.addProduct});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double deposit = 0.33;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var auth = FirebaseAuth.instance;
  User? user;
  List<CartItemsModel> cartItems = [];
  int totalPrice = 0 ;
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff2b410e),
          title: Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('AgriHawk')),
                const Spacer(),
                Text(
                  DateTime.now().toString().substring(0, 10),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: CustomFormField(
                  hint: "اسم العميل",
                  lines: 1,
                  isPassword: false,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<CartItemsModel>>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var cartItemList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                  cartItems = cartItemList ??[];
                  if (cartItemList?.isEmpty == true) {
                    return Center(
                        child: Text(
                      "!! فاضي ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ));
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final cartItem = cartItemList![index];
                      return AddedProduct(
                        cartItemsModel: cartItem,
                        ProductPrice: cartItem.price.toString(),
                        ProductName: cartItem.product ?? "",
                      );
                    },
                    itemCount: cartItemList?.length ?? 0,
                  );
                },
                stream: MyDataBase.getItemRealTimeUpdate(
                  user?.uid ?? "",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Icon(
                  Icons.attach_money_outlined,
                  size: 40,
                ),
                const Text(
                  'Total Price  :  ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                StreamBuilder<QuerySnapshot<CartItemsModel>>(
                  builder: (context, cartItemSnapshot) {
                    if (cartItemSnapshot.hasError) {
                      return Container();
                    }
                    if (cartItemSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var cartItemList = cartItemSnapshot.data?.docs
                        .map((doc) => doc.data() as CartItemsModel)
                        .toList();
                    int total = 0;
                    if (cartItemList != null && cartItemList.isNotEmpty) {
                      total = cartItemList
                          .map((cart) => cart.price ?? 0)
                          .reduce((a, b) => a + b);
                    }
                    totalPrice = total;
                    return Column(
                      children: [
                        Text(
                          ': $total LE',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                  stream: MyDataBase.getItemRealTimeUpdate(user?.uid ?? ""),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                addOrder();
              },
              child: Container(
                  height: 70,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: const Center(
                      child: Text(
                    "Order Now",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ))),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }

  void addOrder() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    String customerName = nameController.text;
    String userId = user?.uid ?? '';
    OrderModel order = OrderModel(
      customerName: customerName,
      cartItems: cartItems,
      dateTime: DateTime.now(),
      totalPrice: totalPrice,
    );

    await MyDataBase.addOrder(userId,order);

    await MyDataBase.deleteCartItems(userId);

    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
      msg: "تمت إضافة الطلب بنجاح",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
