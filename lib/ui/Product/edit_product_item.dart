import 'package:new_todo/import.dart';


class EditPriceItem extends StatefulWidget {
  AddProductModel addProductModel;

  EditPriceItem({required this.addProductModel});

  @override
  State<EditPriceItem> createState() => _SaleInvoiceItemState();
}

class _SaleInvoiceItemState extends State<EditPriceItem> {
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    priceController =
        TextEditingController(text: widget.addProductModel.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 7.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                  child: Text(widget.addProductModel.product ?? ""),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.addProductModel.price = int.parse(priceController.text);
                    });
                    MyDataBase.editProduct(
                      widget.addProductModel.id ?? '',
                      widget.addProductModel.price ?? 0,
                    );
                  },
                  child: Text("ok"),
                )
              ],
            ),
            CustomTextFormField(
              Label: "السعر",
              controller: priceController,
              validator: (p0) {},
            )
          ],
        ),
      ),
    );
  }
}
