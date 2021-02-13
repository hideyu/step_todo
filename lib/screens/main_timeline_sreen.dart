import 'package:flutter/material.dart';
import 'package:step_todo/components/todo_item_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainTimeLineScreen extends StatefulWidget {
  static String id = 'main_timeline_screen';
  @override
  _MainTimeLineScreenState createState() => _MainTimeLineScreenState();
}

class _MainTimeLineScreenState extends State<MainTimeLineScreen> {
  // 1. Firebase authインスタンスを生成
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore
      .instance; // latest versionではFirestore -> FirebaseFirestoreに変更になってる
  User loggedInUser; // latest versionではFirebaseUser -> Userに変更になってる
  String todoItem;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // 2. Userがsign in しているかどうかを確認する処理
  void getCurrentUser() {
    try {
      final user = _auth.currentUser; // latest versionではメソッドじゃなくてプロパティになった
      // final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  // Firestoreのデータを取得する処理(Udemyと書き方が変わっているので注意)
  void getTodoItems() async {
    final todoItems = await _firestore
        .collection('stepTodos')
        .get(); // todoItemsにはFuture<Querysnapshot>が入る
    for (var todoItem in todoItems.docs) {
      // todoItems.docsにはDocumentSnapshotのListが格納されている
      print(todoItem.data()); // message.data()で各データにアクセスできる
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔥 Step Goal Todo 🔥'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          Text('${loggedInUser.email}でログインしています'),
          StreamBuilder(
            stream: _firestore.collection('stepTodos').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final todoItems = snapshot.data.docs;

                List<Text> todoListWidgets = [];
                for (var todoItem in todoItems) {
                  final todoItemText = todoItem.data()['item'];

                  final todoItemWidget = Text('$todoItemText by xxx');
                  todoListWidgets.add(todoItemWidget);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: todoListWidgets,
                );
              }
              return Container();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getTodoItems();
        },
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
