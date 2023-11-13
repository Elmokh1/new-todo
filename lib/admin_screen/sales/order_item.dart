import 'package:new_todo/import.dart';
import '../../database/model/user_model.dart' as MyUser;

class OrderItem extends StatefulWidget {
  final OrderModel orderModel;
  String userId;

  OrderItem({required this.orderModel, required this.userId});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Container(
          // padding: EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            // Background color
            borderRadius: BorderRadius.circular(12.0),
            // Adjust the value to control the roundness
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 2), // Offset
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ), // Adjust the value to control the roundness
                  ),
                  child: Center(
                    child: Text(
                      " ${widget.orderModel.customerName ?? 'empty'}",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                for (var cartItem
                    in widget.orderModel.cartItems ?? <CartItemsModel>[])
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Text("${cartItem.product ?? 'N/A'}")),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Column(
                              children: [
                                Text(
                                    " ${cartItem.quantity?.toString() ?? 'empty'}"),
                              ],
                            ))),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '${cartItem.price.toString()}' ?? 'N/A',
                                style: const TextStyle(),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text('\$' ?? 'N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Divider(
                  thickness: 1,
                  color: Colors.green.withOpacity(.4),
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ), // Adjust the value to control the roundness
                  ),
                  child: Center(
                    child: Text(
                      "Total Price:  ${widget.orderModel.totalPrice ?? 'N/A'} \$",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: widget.orderModel.accept == true
                            ? Text(
                                "Done",
                                style: TextStyle(color: Colors.green),
                              )
                            : Text(
                                "Accept",
                                style: TextStyle(fontSize: 20),
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (widget.orderModel.accept == false) {
                            widget.orderModel.accept =
                                !widget.orderModel.accept;
                          }
                        });
                        MyDataBase.editOrder(
                          widget.userId ?? "",
                          widget.orderModel.id ?? "",
                          widget.orderModel.accept,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
