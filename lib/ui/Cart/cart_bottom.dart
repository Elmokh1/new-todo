
import 'package:new_todo/import.dart';



class CartBottom extends StatefulWidget {

  Function? function;

  CartBottom({this.function});

  @override
  State<CartBottom> createState() => _CartBottomState();
}

class _CartBottomState extends State<CartBottom> {
  List<AddedProduct> addedProduct = [];

  void initState() {
    super.initState();
    addedProduct = [];
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Tap();
      },
      child: Container(
        width: 300,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: Colors.black
        ),
        child: Center(
          child: Text(
            "Go to Cart",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  void Tap(){
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CartPage(addProduct : addedProduct),
        ),
      );
    }
    );
  }
  void OnClicked(AddedProduct product) {
    setState(() {
      print(product.ProductName);
    });
  }
}
