import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteTile extends StatelessWidget {
  final int length;
  final int colorIndex;
  final String text;
  NoteTile(
      {super.key,
      required this.length,
      required this.colorIndex,
      required this.text});

  final List<Gradient> colors = [
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 159, 221, 214),
        Color.fromARGB(255, 103, 205, 195),
        Color.fromARGB(255, 94, 175, 155),
        Color.fromARGB(255, 64, 154, 141)
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 196, 227, 233),
        Color.fromARGB(255, 133, 188, 200),
        Color.fromARGB(255, 98, 153, 164),
        Color.fromARGB(255, 78, 149, 163)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 196, 227, 233),
        Color.fromARGB(255, 133, 188, 200),
        Color.fromARGB(255, 98, 153, 164),
        Color.fromARGB(255, 78, 149, 163)
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 136, 209, 185),
        Color.fromARGB(255, 103, 182, 157),
        Color.fromARGB(255, 91, 184, 161),
        Color.fromARGB(255, 77, 157, 145)
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 19, 78, 58),
        Color.fromARGB(255, 52, 155, 122),
        Color.fromARGB(255, 64, 157, 134),
        Color.fromARGB(255, 115, 198, 185)
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    const LinearGradient(
      colors: [
        Color.fromARGB(255, 176, 195, 192),
        Color.fromARGB(255, 110, 153, 148),
        Color.fromARGB(255, 80, 127, 115),
        Color.fromARGB(255, 56, 93, 88)
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          gradient: colors[colorIndex],
        ),
        height: (length / 2) * 5,
        width: length * 10,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.manjari(
                textStyle:
                    TextStyle(color: theme.colorScheme.tertiary, fontSize: 17)),
          ),
        ),
      ),
    );
  }
}


// Column(
                  //   children: [
                  //     AnimatedBuilder(
                  //         animation: _controller!,
                  //         child: NoteTile(
                  //             length: text[0].length,
                  //             colorIndex: 1,
                  //             text: text[0]),
                  //         builder: (BuildContext context, Widget? child) {
                  //           return Transform.translate(
                  //             offset: Offset(_controller!.value * 200, 0.0),
                  //             child: child,
                  //           );
                  //         }),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         AnimatedBuilder(
                  //             animation: _controller2!,
                  //             child: NoteTile(
                  //                 length: text[1].length,
                  //                 colorIndex: 0,
                  //                 text: text[1]),
                  //             builder: (BuildContext context, Widget? child) {
                  //               return Transform.translate(
                  //                 offset:
                  //                     Offset(_controller2!.value * -135, 0.0),
                  //                 child: child,
                  //               );
                  //             }),
                  //       ],
                  //     ),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         AnimatedBuilder(
                  //             animation: _controller!,
                  //             child: SingleChildScrollView(
                  //               scrollDirection: Axis.horizontal,
                  //               child: Row(
                  //                 children: [
                  //                   NoteTile(
                  //                       length: text[2].length,
                  //                       colorIndex: 2,
                  //                       text: text[2]),
                  //                   const SizedBox(
                  //                     width: 5,
                  //                   ),
                  //                   NoteTile(
                  //                       length: text[4].length,
                  //                       colorIndex: 4,
                  //                       text: text[4]),
                  //                 ],
                  //               ),
                  //             ),
                  //             builder: (BuildContext context, Widget? child) {
                  //               return Transform.translate(
                  //                 offset: Offset(_controller2!.value * 175, 0.0),
                  //                 child: child,
                  //               );
                  //             }),
                  //       ],
                  //     ),
                  //     AnimatedBuilder(
                  //         animation: _controller2!,
                  //         child: NoteTile(
                  //             length: text[3].length,
                  //             colorIndex: 3,
                  //             text: text[3]),
                  //         builder: (BuildContext context, Widget? child) {
                  //           return Transform.translate(
                  //             offset: Offset(_controller!.value * -250, 0.0),
                  //             child: child,
                  //           );
                  //         }),
                  //         NoteTile(
                  //             length: text[5].length,
                  //             colorIndex: 5,
                  //             text: text[5]),
                          
                  //   ],
                  // )
