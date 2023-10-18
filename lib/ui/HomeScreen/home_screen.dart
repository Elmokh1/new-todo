import 'package:flutter/material.dart';
import 'package:new_todo/ui/HomeScreen/addTaskBottomSheet.dart';
import 'package:new_todo/ui/HomeScreen/settings/settings.dart';
import 'package:new_todo/ui/HomeScreen/todos_list/todos_list.dart';

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
      appBar: AppBar(),
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
      context: context,
      builder: (context) {
        return AddTaskBottomSheet();
      },
    );
  }
  var tabs = [
    TodoList(),
    Done(),

  ];
}


