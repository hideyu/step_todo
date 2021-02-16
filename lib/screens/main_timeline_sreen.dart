import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_todo/components/popup_dialog.dart';
import 'package:step_todo/functions/firebase_helper.dart';

class MainTimeLineScreen extends StatefulWidget {
  static String id = 'main_timeline_screen';
  @override
  _MainTimeLineScreenState createState() => _MainTimeLineScreenState();
}

class _MainTimeLineScreenState extends State<MainTimeLineScreen> {
  // 1. Firebase authインスタンスを生成
  FirebaseHelper firebaseHelper = FirebaseHelper();
  // Stream todoItemSnapshot = FirebaseHelper().getTodoItemSnapshot();
  // final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  String todoItem;

  @override
  void initState() {
    super.initState();
    loggedInUser = firebaseHelper.getCurrentUser();
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
          // TextField(
          //   onChanged: (value) {
          //     todoItem = value;
          //     print(todoItem);
          //   },
          // ),
          // FlatButton(
          //   onPressed: () {
          //     print('flat button is pressed!!!');
          //     firebaseHelper.addTodoItems(todoItem: todoItem);
          //   },
          //   child: Text('send'),
          //   color: Colors.blueGrey,
          //   height: 50,
          // ),
          RaisedButton(
            child: Text('Register Task'),
            onPressed: () {
              print('popup is launched...');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialogWithField(
                    loggedInUser: loggedInUser,
                  );
                },
              );
            },
          ),
          // PopupDialog(),
          SizedBox(
            height: 30.0,
          ),
          Text('================='),
          StreamBuilder(
            stream: _firestore.collection('stepTodos').snapshots(),
            // stream: todoItemSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final todoItems = snapshot.data.docs;

                List<Text> todoListWidgets = [];
                // TODO: loggedinUserのdataだけ取得する
                // TODO: リファクターが必要
                for (var todoItem in todoItems) {
                  final todoItemText = todoItem.data()['title'];
                  final todoTargetLevel = todoItem.data()['targetLevel'];
                  final todoDifficlutyScore =
                      todoItem.data()['difficultyScore'];
                  final todoIsDone = todoItem.data()['isDone'];
                  final todoTargetDate = todoItem.data()['targetDate'].toDate();

                  final todoItemWidget = Text(
                      'todo: $todoItemText, lev: $todoTargetLevel, score: $todoDifficlutyScore, isDone: $todoIsDone, date: $todoTargetDate');
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
          firebaseHelper.getTodoItems();
        },
      ),
    );
  }
}
