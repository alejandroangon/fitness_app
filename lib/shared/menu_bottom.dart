// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MenuBotton extends StatelessWidget {
  const MenuBotton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int idx) {
          switch (idx) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/bmi');
              break;
            default:
          }
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.monitor_weight), label: 'IMC'),
        ]);
  }
}
