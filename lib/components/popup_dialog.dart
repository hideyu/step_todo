import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_todo/functions/firebase_helper.dart';

class AlertDialogWithField extends StatefulWidget {
  const AlertDialogWithField({this.loggedInUser});
  final User loggedInUser;

  @override
  _AlertDialogWithFieldState createState() => _AlertDialogWithFieldState();
}

class _AlertDialogWithFieldState extends State<AlertDialogWithField> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  String todoInput; // タスクの内容
  int selectedLevel; // タスクのレベル（大中小）
  int diffucultyLevel; // タスクのスコア（0~100）
  DateTime _date = new DateTime.now(); // 現在日時

  Widget _buildRegisterButton() {
    return RaisedButton(
      child: Text('Register'),
      onPressed: () {
        setState(() {
          // TODO: firebaseに登録する処理
          firebaseHelper.addTodoItems(
              todoItem: todoInput,
              todoDate: _date,
              targetLevel: selectedLevel,
              loggedInUser: widget.loggedInUser);
          print('registering to firebase...');
        });
      },
    );
  }

  String _dateLabel = '日付を選択してください';
  // ボタン押した時のイベント
  void onPressedRaisedButton() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime.now()
            .add(new Duration(days: 360))); // TODO: より後年度の値も入れれるようにする

    if (picked != null) {
      // 日時の反映
      setState(() {
        _date = picked;
        _dateLabel = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('It says'),
      children: <Widget>[
        Column(
          children: [
            // TODO: ダイアログのスタイリング
            SizedBox(
              width: 500.0,
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'title',
              ),
              onChanged: (value) {
                setState(() {
                  todoInput = value;
                  print(todoInput);
                });
              },
            ),
            Row(
              children: [
                Text(_dateLabel),
                RaisedButton(
                  onPressed: () {
                    // 押した時のイベントを宣言。
                    onPressedRaisedButton();
                  },
                  child: Text('日付を選択'),
                ),
              ],
            ),
            DropdownButton(
              isExpanded: true,
              value: selectedLevel,
              hint: Text("タスクのレベルを選択してね"),
              items: [
                DropdownMenuItem(
                  child: Text('大テーマ'),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text('中間目標'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('小タスク'),
                  value: 2,
                )
              ],
              onChanged: (value) {
                setState(() {
                  // print(value);
                  selectedLevel = value;
                  print(selectedLevel);
                });
              },
            ),
            // TextField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     icon: Icon(Icons.lock),
            //     labelText: 'diffucultyScore(optional)',
            //   ),
            // ),
          ],
        ),
        _buildRegisterButton(),
      ],
    );
  }
}
