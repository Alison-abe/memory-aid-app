import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:memory_aid/provider/exercise_provider.dart';
import 'package:memory_aid/screens/exercise/progress.dart';
import 'package:memory_aid/widget/questionpage.dart';
import 'package:provider/provider.dart';
import '../../widget/appbar_decoration.dart';

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String CompletedTest_first = "Wohooooo!! ";
    String AttemptTest_first = "Hurry Up!!! ";
    String CompletedTest_second = "You had completed Today's Exercise!! ";
    String AttemptTest_second = " Complete Today's Exercise!! ";
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: AppBar(
          toolbarHeight: 70,
          flexibleSpace: const AppbarDecoration(),
          centerTitle: true,
          title: Text(
            'Exercise',
            style: TextStyle(
                color: theme.colorScheme.tertiary,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            Tooltip(
              message: "Progress",
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const Progress_Page()));
                  },
                  icon: Icon(
                    Icons.bar_chart_outlined,
                    color: theme.colorScheme.tertiary,
                  )),
            )
          ],
        ),
        body: FutureBuilder<bool>(
          future: Provider.of<ExerciseProvider>(context, listen: false)
              .getIsAttempted(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              bool isAttempted = snapshot.data ?? false;
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Consumer<ExerciseProvider>(
                    builder: (context, provider, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isAttempted
                                  ? CompletedTest_first
                                  : AttemptTest_first,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: theme.colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                            ),
                            Text(
                              isAttempted
                                  ? CompletedTest_second
                                  : AttemptTest_second,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: theme.colorScheme.tertiary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            isAttempted
                                ? Align(
                                    alignment: Alignment.bottomLeft,
                                    child: FutureBuilder<int>(
                                        future: Provider.of<ExerciseProvider>(
                                                context,
                                                listen: false)
                                            .getScore(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<int> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Row(
                                              children: [
                                                Text(
                                                  'Score : ',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .tertiary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)),
                                                ),
                                                Text(
                                                  '${snapshot.data ?? 0}',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: theme
                                                              .colorScheme
                                                              .tertiary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)),
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  )
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                theme.colorScheme.secondary),
                                        minimumSize: MaterialStateProperty
                                            .all<Size>(const Size(200,
                                                50)) // Set the desired color
                                        ),
                                    onPressed: () async {
                                      String currentDate =
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.now().subtract(
                                                  const Duration(days: 1)));
                                      var exercise = await FirebaseFirestore
                                          .instance
                                          .collection(
                                              'users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
                                          .doc('${currentDate}')
                                          .get();

                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  QuestionPAge(
                                                    index: 1,
                                                    question:
                                                        exercise['question1'],
                                                    answer: exercise['answer1'],
                                                    exercise: exercise,
                                                    score: 0,
                                                  )));
                                      // isAttempted = true;
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(
                                              '${FirebaseAuth.instance.currentUser!.uid}')
                                          .update({'isAttempted': true});
                                    },
                                    child: Text(
                                      'Start',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: theme.colorScheme.tertiary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ))
                          ],
                        )),
              );
            }
          },
        ),
      ),
    );
  }
}
