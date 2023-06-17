import 'package:flutter/material.dart';

import '../../widget/appbar_decoration.dart';

class Exercise extends StatelessWidget {
  const Exercise({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: AppBar(
          toolbarHeight: 70,
                  flexibleSpace:const AppbarDecoration(),
          //backgroundColor:theme.colorScheme.secondary,
                centerTitle: true,
          title: Text('Exercise',style: TextStyle(color: theme.colorScheme.tertiary,fontSize: 20,fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }
}