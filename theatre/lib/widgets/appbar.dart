import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
       backgroundColor: const Color.fromARGB(255, 13, 13, 13),
       titleSpacing: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text("CINEBOX",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                //fontFamily: 'rivera',
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
