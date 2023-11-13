import 'package:new_todo/import.dart';

class AddedProduct extends StatefulWidget {
  final String ProductName;
  final String ProductPrice;
  late String userInput;
  CartItemsModel cartItemsModel;

  AddedProduct({
    required this.ProductName,
    required this.ProductPrice,
    required this.cartItemsModel,
  }) : userInput = "";

  @override
  State<AddedProduct> createState() => _AddedProductState();
}

class _AddedProductState extends State<AddedProduct> {
  double productPrice = 0.0;
  late TextEditingController myController;

  @override
  void initState() {
    super.initState();
    myController = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      height: 50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.ProductName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:  Text(
                          widget.cartItemsModel.quantity.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.ProductPrice} LE",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
