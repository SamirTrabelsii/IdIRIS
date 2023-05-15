import 'package:flutter/material.dart';

class welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background picc-01.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 10, top: 50),
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text:
                    'Welcome to your recognition app\nmade by smart aid technologies',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                ),
              ),
              TextSpan(
                text: 'Iris recognition \n\n',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
