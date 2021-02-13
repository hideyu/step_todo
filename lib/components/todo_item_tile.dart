import 'package:flutter/material.dart';

class TodoItemTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('2/9'),
        SizedBox(
          width: 10,
        ),
        Text('hogehoge'),
      ],
    );
  }
}
