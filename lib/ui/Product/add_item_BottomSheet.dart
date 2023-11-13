
import 'package:new_todo/import.dart';



class AddItemBottomSheet extends StatefulWidget {

  AddProductModel addProductModel;


  AddItemBottomSheet({required this.addProductModel});

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet>  {
  TextEditingController quantityController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Add Product',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            CustomTextFormField(
              Label: "الكميه",
              controller: quantityController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'please enter quantity';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16)),
                  onPressed: () {
                    addProductToCart();
                  },
                  child: const Text(
                    'Add ',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void addProductToCart()  async {
   int totalProductPrice = (widget.addProductModel.price?? 0 ) * (int.parse(quantityController.text));
    if (formKey.currentState?.validate() == false) {
      return;
    }
    CartItemsModel cartItemModel = CartItemsModel(
      quantity:int.parse(quantityController.text ),
      price: totalProductPrice ,
      product: widget.addProductModel.product,
    );
    await MyDataBase.addItemToCart(user?.uid?? "", cartItemModel);
    DialogUtils.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Product Add Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
