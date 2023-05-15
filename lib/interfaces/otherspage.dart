import 'package:flutter/material.dart';

class otherspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/backgroundpic2.png"),
        fit: BoxFit.fill,
      ),
    ));
  }
}
