import 'package:new_todo/import.dart';


class EditPrice extends StatefulWidget {
  static const String routeName = "EditPrice";

  @override
  _EditPriceState createState() => _EditPriceState();
}

class _EditPriceState extends State<EditPrice> {
  String searchQuery = '';
  late Stream<QuerySnapshot<AddProductModel>> searchStream;

  @override
  void initState() {
    super.initState();
    searchStream = MyDataBase.getAddProductRealTimeUpdate();
  }

  void handleSearch() {
    if (searchQuery.isNotEmpty) {
      searchStream = MyDataBase.getAddProductCollection()
          .where('product', isGreaterThanOrEqualTo: searchQuery)
          .where('product', isLessThanOrEqualTo: searchQuery + '\uf8ff')
          .snapshots();
    } else {
      searchStream = MyDataBase.getAddProductRealTimeUpdate();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: handleSearch,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<AddProductModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var productList =
                snapshot.data?.docs.map((doc) => doc.data()).toList();

                if (productList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "!No Item Found ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return EditPriceItem(addProductModel: product);
                  },
                  itemCount: productList?.length ?? 0,
                );
              },
              stream: searchStream,
            ),
          ),
        ],
      ),
    );
  }
}
