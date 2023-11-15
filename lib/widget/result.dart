import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_aid/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../provider/exercise_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.colorScheme.secondary,
          onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen()));
          
        },
        child: const Icon(Icons.home),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Congratulations!!',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 25))),
              Text('You have Completed the test',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                height: 200,
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 176, 195, 192),
                      Color.fromARGB(255, 110, 153, 148),
                      Color.fromARGB(255, 80, 127, 115),
                      Color.fromARGB(255, 56, 93, 88)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Center(
                  child: FutureBuilder<int>(
                                future: Provider.of<ExerciseProvider>(context,
                                        listen: false)
                                    .getScore(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<int> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Score : ',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: theme
                                                      .colorScheme.tertiary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                        Text(
                                          '${snapshot.data ?? 0}',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: theme
                                                      .colorScheme.tertiary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
