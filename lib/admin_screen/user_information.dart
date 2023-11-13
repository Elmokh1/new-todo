
import 'package:new_todo/import.dart';
import 'package:new_todo/database/model/user_model.dart' as MyUser;



class UserInformation extends StatefulWidget {

  MyUser.User user;
  UserInformation(this.user);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tabs = [
      NotDone(widget.user),
      ReportDone(widget.user),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pushNamed(context,AdminScreen.routeName);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalesScreen(
                    user: widget.user,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.add_business_sharp,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: tabs[selectedIndex],
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
                icon: Icon(
                  Icons.list,
                  size: 32,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle,
                  size: 32,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }


}
