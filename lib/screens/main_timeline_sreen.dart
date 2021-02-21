import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step_todo/components/add_new_goal_button.dart';
import 'package:step_todo/components/popup_dialog_todo.dart';
import 'package:step_todo/functions/firebase_helper.dart';

class MainTimeLineScreen extends StatefulWidget {
  static String id = 'main_timeline_screen';
  @override
  _MainTimeLineScreenState createState() => _MainTimeLineScreenState();
}

class _MainTimeLineScreenState extends State<MainTimeLineScreen> {
  // 1. Firebase authインスタンスを生成
  FirebaseHelper firebaseHelper = FirebaseHelper();
  // final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User _loggedInUser;

  String todoItem;

  @override
  void initState() {
    super.initState();
    _loggedInUser = firebaseHelper.getCurrentUser();
  }

  List<Widget> TabList = [];
  void TabListFuture() async {
    QuerySnapshot goalsSnapshot = await firebaseHelper.getCollections('goals');
    List<QueryDocumentSnapshot> goalsDocsList = goalsSnapshot.docs;
    TabList = []; // TabListを初期化
    for (var goal in goalsDocsList) {
      final String goalTitle = goal.data()['goalTitle'];
      final Tab goalTab = Tab(
        child: Text(goalTitle),
      );
      TabList.add(goalTab);

      print(goalTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ビルドするごとにタブ情報をFirestoreから取得する
    // TODO: 読み込み中のスピナー実装する
    TabListFuture();

    return FutureBuilder(
      future: firebaseHelper.getCollections('goals'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return DefaultTabController(
          length: snapshot.data.docs.length, // Firestoreに登録されてるデータの数で動的に変更
          child: Scaffold(
            appBar: AppBar(
              title: Text('🔥 Step Goal Todo 🔥'),
              backgroundColor: Colors.red,
              actions: [
                AddNewGoalIconButton(),
              ],
              bottom: TabBar(
                tabs: TabList,
              ),
            ),
            body: TabBarView(
              children: [
                TimeLineListView(
                  loggedInUser: _loggedInUser,
                  firestore: _firestore,
                ),
                Icon(Icons.directions_transit),
                // Icon(Icons.directions_bike),
                // Icon(Icons.access_alarm_sharp),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // firebaseHelper.getCollections('goals');
                print('snapshot is ...');
                print(snapshot.data.docs.length);

                print('TabListFuture is ...');
                TabListFuture();
              },
            ),
          ),
        );
      },
    );
  }
}

class TimeLineListView extends StatelessWidget {
  const TimeLineListView({
    @required this.loggedInUser,
    @required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final User loggedInUser;
  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('${loggedInUser.email}でログインしています'),
        RaisedButton(
          child: Text('Register Task'),
          onPressed: () {
            print('popup is launched...');
            showDialog(
              context: context,
              builder: (context) {
                return PopupTodoInputField(
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
                final todoDifficlutyScore = todoItem.data()['difficultyScore'];
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
    );
  }
}
