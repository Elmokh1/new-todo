import 'package:new_todo/import.dart';
class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      appBar:AppBar(
        actions: [
          InkWell(
            child: Icon(Icons.logout,color: Colors.black,size: 30,),
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          ),

        ],
        leading: InkWell(
          onTap: (){
            Navigator.pushReplacementNamed(context, Product.routeName);
          },
            child: Icon(Icons.production_quantity_limits_rounded,size: 30,color: Colors.black,)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(width: 4, color: Colors.white),
        ),
        onPressed: () {
          showAddTaskSheet();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list, size: 32,), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle, size: 32,), label: ''),
          ],
        ),
      ),
    );
  }
  void showAddTaskSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AddTaskBottomSheet(),
          ),
        );
      },
    );
  }

  var tabs = [
    TodoList(),
    Done(),

  ];
}


