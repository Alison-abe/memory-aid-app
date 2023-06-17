
import 'package:flutter/material.dart';

class AppbarDecoration extends StatelessWidget {
  const AppbarDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            colors: 
            [
             Color.fromARGB(255, 150, 181, 165),
             Color.fromARGB(255, 135, 167, 150),
             Color.fromARGB(255, 91, 149, 119),
             Color.fromARGB(255, 58, 120, 88),
             Color.fromARGB(255, 46, 84, 65)
             ]
             , 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight, 
            )
        ),
      );
  }
}