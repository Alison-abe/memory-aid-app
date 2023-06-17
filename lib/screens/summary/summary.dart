import 'package:flutter/material.dart';

import '../../widget/appbar_decoration.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: AppBar(
          toolbarHeight: 70,
          flexibleSpace: const AppbarDecoration(),
          //backgroundColor:theme.colorScheme.secondary,
          centerTitle: true,
          title: const Text(
            'Summary',
            style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
