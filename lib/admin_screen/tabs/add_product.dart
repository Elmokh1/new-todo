import 'package:new_todo/import.dart';

class AddProduct extends StatefulWidget {
  static const String routeName ="AddProduct";

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  var PriceController = TextEditingController();
  var desController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormField(
                    controller: nameController,
                    Label: "اسم المنتج",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Product Name ';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormField(
                    controller: PriceController,
                    Label: "السعر",
                    // controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Product Price ';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomTextFormField(
                    controller: desController,
                    Label: "التفاصيل",
                    lines: 20,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Product Details ';
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 80)
                  ),
                  onPressed: () {
                    Add();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

  void Add() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    int? price = int.tryParse(PriceController.text);
    AddProductModel addProduct = AddProductModel(
      product: nameController.text ,
      price: price,
      des: desController.text,
    );
    print('Adding product: $addProduct');
    print(addProduct.id);
    await MyDataBase.addProduct(addProduct);

    print('Productq added successfully');
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