import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataMap {
  static const title = 'title';
  static const targetLevel = 'targetLevel';
  static const difficultyScore = 'difficultyScore';
  static const targetDate = 'targetDate';
  static const isDone = 'isDone';
  static const user = 'user';
}

class FirebaseHelper {
  // 1. Firebase authインスタンスを生成
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  // 2. Userがsigninしているかどうかを確認する処理
  // TODO: dynamicでいいか不明
  dynamic getCurrentUser() {
    try {
      final user = _auth.currentUser;
      // final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
        return loggedInUser;
      }
    } catch (e) {
      print(e);
    }
  }

  // 3. Firestoreのデータ（Stream）を取得する処理
  Stream getTodoItemSnapshot() {
    final todoItemSnapshot = _firestore.collection('stepTodos').snapshots();
    return todoItemSnapshot;
  }

  // 3. Firestoreのデータ（Future）を取得する処理
  dynamic getTodoItems() async {
    final todoItems = await _firestore
        .collection('stepTodos')
        .get(); // todoItemsにはFuture<Querysnapshot>が入る
    for (var todoItem in todoItems.docs) {
      // todoItems.docsにはDocumentSnapshotのListが格納されている
      print(todoItem.data()); // todoitem.data()で各データにアクセスできる
    }
    return todoItems;
  }

  // 4. Firestoreにデータを登録する処理
  void addTodoItems({String todoItem}) async {
    DateTime createdAt = DateTime(2021, 2, 13, 14, 10);

    _firestore.collection('stepTodos').add(
      {
        FirebaseDataMap.title: todoItem,
        FirebaseDataMap.targetLevel: 0,
        FirebaseDataMap.difficultyScore: 50,
        FirebaseDataMap.targetDate: Timestamp.fromDate(createdAt),
        FirebaseDataMap.isDone: false,
        FirebaseDataMap.user: loggedInUser.email,
      },
    );
  }
}
