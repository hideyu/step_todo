import 'package:flutter/material.dart';
import 'package:step_todo/components/todo_item.dart';

class MainTimeLineScreen extends StatefulWidget {
  static String id = 'main_timeline_screen';
  @override
  _MainTimeLineScreenState createState() => _MainTimeLineScreenState();
}

class _MainTimeLineScreenState extends State<MainTimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔥 Step Goal Todo 🔥'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          TodoItem(),
          TodoItem(),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       title: Text('Setting'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       title: Text('Search'),
      //     ),
      //   ],
      //   // currentIndex: _selectedIndex,
      //   onTap: null,
      // ),
    );
  }
}
