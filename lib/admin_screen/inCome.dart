import 'package:new_todo/import.dart';
import 'package:new_todo/database/model/user_model.dart' as MyUser;



class IncomeScreen extends StatelessWidget {
  final List<int> sort = [5, 4, 3, 0, 1, 7,2,6,8,9,10,11,12,13,14,15,16,17,18,19,20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<MyUser.User>>(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var userList =
                snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (userList?.isEmpty == true) {
                  return Center(
                    child: Text(
                      "!! فاضي ",
                      style: GoogleFonts.abel(
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final user = userList;
                    return IncomeItem(user: user);
                  },
                  itemCount: 1,
                );
              },
              stream: MyDataBase.getUserRealTimeUpdate(),
            ),
          ),
          Text("Total Income"),
        ],
      ),
    );
  }
}
