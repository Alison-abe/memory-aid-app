import 'package:flutter/material.dart';
import 'package:memory_aid/screens/exercise/monthly_progress.dart';
import 'package:memory_aid/widget/lineChart.dart';
import 'package:memory_aid/widget/pricePoint.dart';

class Progress_Page extends StatefulWidget {
  const Progress_Page({super.key});

  @override
  State<Progress_Page> createState() => _Progress_PageState();
}

class _Progress_PageState extends State<Progress_Page> {
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
                child: LineChartWidget(futurePoints: pricePoints),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>const MProgress_Page()));
              }, child: Text("Monthly Progress!")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Go Back!"))
            ],
          ),
        ),
      ),
    );
  }
}
