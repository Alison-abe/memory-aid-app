import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memory_aid/screens/recording/record_button.dart';
import 'package:memory_aid/widget/carousal.dart';
import 'package:memory_aid/widget/note_tile.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

const String text1 = "Do exercises Daily";
const String text2 = "Interact with more people";
List<String> text = [
  "Do exercise Daily...",
  "Interact with more people",
  "Eat healthy food",
  "Have enough sleep...",
  "Drink water",
  "Stay mentally active..."
];
bool _selected = false;

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _controller2;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
    _controller2 =
        AnimationController(duration: const Duration(seconds: 12), vsync: this)
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 40,
            ),
            Expanded(
                //flex: 2,
                child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                  color: theme.colorScheme.primary, child: const Carousal()),
            )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                    color: theme.colorScheme.primary,
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(20), child: RecordButton()),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
