import 'package:new_todo/import.dart';
import 'package:new_todo/ui/Product/details_screen.dart';

class ProductItem extends StatefulWidget {
  AddProductModel addProductModel;

  ProductItem({required this.addProductModel});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  var auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
  }

  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                child:
                    Text("${widget.addProductModel.price.toString()} \$" ?? ""),
              ),
              InkWell(
                onTap: () {
                  showItemModal();
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          pDetails: widget.addProductModel.des,
                        ),
                      ),
                    );
                  },
                  child: Text(widget.addProductModel.product ?? ""),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showItemModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddItemBottomSheet(
              addProductModel: widget.addProductModel,
            ),
          ),
        );
      },
    );
  }
}
