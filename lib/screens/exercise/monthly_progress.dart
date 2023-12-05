import 'package:flutter/material.dart';

import 'package:memory_aid/widget/monthly_lineChart.dart';
import 'package:memory_aid/widget/pricePoint.dart';

class MProgress_Page extends StatefulWidget {
  const MProgress_Page({super.key});

  @override
  State<MProgress_Page> createState() => _MProgress_PageState();
}

class _MProgress_PageState extends State<MProgress_Page> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Center(
                  child: Text(
                "PROGRESS",
                style: TextStyle(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    ),
              )),
              const SizedBox(height: 30,),
              Container(
                child: MLineChartWidget(futurePoints: monthly_pricePoints),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Weekly Progress!"))

            ],
          ),
        ),
      ),
    );
  }
}
