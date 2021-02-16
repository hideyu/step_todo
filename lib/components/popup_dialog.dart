import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Alert with Custom Content'),
              onPressed: () => _onAlertWithCustomContentPressed(context),
            ),
          ],
        ),
      ),
    );
  }

// Alert custom content
  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "タスクの登録",
        style: AlertStyle(
          animationType: AnimationType.fromLeft,
        ),
        content: Column(
          children: <Widget>[
            SizedBox(
              width: 500.0,
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'title',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'targetDate',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'targetLevel',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'diffucultyScore(optional)',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              print('hogehgoe'),
              print('fugafuga'),
              // Navigator.pop(context)
            },
            child: Text(
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
