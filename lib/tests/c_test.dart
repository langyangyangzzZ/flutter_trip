import 'package:flutter/material.dart';

class CText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("C页面"),
      ),
    );
  }
}
