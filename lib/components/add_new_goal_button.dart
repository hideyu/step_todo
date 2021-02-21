import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_todo/components/popup_dialog_todo.dart';

class AddNewGoalIconButton extends StatelessWidget {
  final User loggedInUser;
  const AddNewGoalIconButton({this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        print("fugafuga");
        // TODO: 新しいゴールを設定するポップアップwidgetをコール
        showDialog(
          context: context,
          builder: (context) {
            return PopupTodoInputField(
              loggedInUser: loggedInUser,
            );
          },
        );
      },
    );
  }
}
