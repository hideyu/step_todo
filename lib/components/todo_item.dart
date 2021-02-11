import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key key,
  }) : super(key: key);

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
