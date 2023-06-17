import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:memory_aid/screens/recording/record_button.dart';
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
    _controller=AnimationController(duration: const Duration(seconds: 10), vsync: this)
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
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  color: theme.colorScheme.primary,
                  child:  Column(
                    children: [
                      AnimatedBuilder(
                          animation: _controller!,
                          child: NoteTile(
                              length: text[0].length,
                              colorIndex: 1,
                              text: text[0]),
                          builder: (BuildContext context, Widget? child) {
                            return Transform.translate(
                              offset: Offset(_controller!.value * 200, 0.0),
                              child: child,
                            );
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                              animation: _controller2!,
                              child: NoteTile(
                                  length: text[1].length,
                                  colorIndex: 0,
                                  text: text[1]),
                              builder: (BuildContext context, Widget? child) {
                                return Transform.translate(
                                  offset:
                                      Offset(_controller2!.value * -135, 0.0),
                                  child: child,
                                );
                              }),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                              animation: _controller!,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    NoteTile(
                                        length: text[2].length,
                                        colorIndex: 2,
                                        text: text[2]),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    NoteTile(
                                        length: text[4].length,
                                        colorIndex: 4,
                                        text: text[4]),
                                  ],
                                ),
                              ),
                              builder: (BuildContext context, Widget? child) {
                                return Transform.translate(
                                  offset: Offset(_controller2!.value * 175, 0.0),
                                  child: child,
                                );
                              }),
                        ],
                      ),
                      AnimatedBuilder(
                          animation: _controller2!,
                          child: NoteTile(
                              length: text[3].length,
                              colorIndex: 3,
                              text: text[3]),
                          builder: (BuildContext context, Widget? child) {
                            return Transform.translate(
                              offset: Offset(_controller!.value * -250, 0.0),
                              child: child,
                            );
                          }),
                          NoteTile(
                              length: text[5].length,
                              colorIndex: 5,
                              text: text[5]),
                          
                    ],
                  )

                    
                  )),
          Expanded(
              child: Container(
            decoration:  BoxDecoration(
              borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
              color: theme.colorScheme.primary,
            ),
            child: const Center(
              child: RecordButton(),
            ),
          ))
        ],
      )),
    );
  }
}
