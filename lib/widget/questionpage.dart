import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:memory_aid/provider/answer_provider.dart';
import 'package:memory_aid/widget/result.dart';
import 'package:provider/provider.dart';

class QuestionPAge extends StatelessWidget {
  final int index;
  final String question;
  final String answer;
  final int score;
  final DocumentSnapshot<Map<String, dynamic>> exercise;
  const QuestionPAge(
      {super.key,
      required this.index,
      required this.question,
      required this.answer,
      required this.exercise,
      required this.score
      });

  @override
  Widget build(BuildContext context) {
    TextEditingController answer = TextEditingController();
    int _score = score;
    int ansresult = 1;
    Provider.of<AnswerProvider>(context, listen: false).initqsattempted(0);
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        floatingActionButton: Visibility(
          visible: index != 3,
          child: FloatingActionButton(
              backgroundColor: theme.colorScheme.secondary,
              onPressed: () {},
              child: IconButton(
                  onPressed: () {
                    print('score:${_score}');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => QuestionPAge(
                              index: index + 1,
                              question: exercise['question${index + 1}'],
                              answer: exercise['answer${index + 1}'],
                              exercise: exercise,
                              score: _score,
                            )));
                  },
                  icon: const Icon(Icons.arrow_forward))),
        ),
        body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index}. ${question}',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: theme.colorScheme.tertiary,
                    fontSize: 25,
                    // fontWeight: FontWeight.bold
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: answer,
                  style: TextStyle(color: theme.colorScheme.tertiary),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: theme.colorScheme.tertiary),
                    label: Text(
                      'Enter answer',
                      style: TextStyle(
                          fontSize: 15,
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.normal),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: theme.colorScheme.tertiary, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<AnswerProvider>(
                  builder: (context,provider,_){
                return Provider.of<AnswerProvider>(context, listen: false)
                              .isqsattempted == 0 ?
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  theme.colorScheme.secondary),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(200, 50))),
                          onPressed: () async {
                 
                            print("${exercise['answer${index}']} ");
                            print(answer.text);
                            ansresult = await Provider.of<AnswerProvider>(context,
                                    listen: false)
                                .Answerquery({
                              "inputs": {
                                "source_sentence":
                                    "${exercise['answer${index}']} ",
                                "sentences": [
                                  answer.text,
                                  answer.text,
                                  answer.text
                                ]
                              }
                            }) ;
                            Provider.of<AnswerProvider>(context, listen: false)
                                .isqsattempted = 1;
                            if (ansresult == 1) {
                              _score=_score+1;
                            }
                          },
                          child: Text(
                            'Check Answer',
                            style: GoogleFonts.poppins(
                                textStyle:
                                    TextStyle(color: theme.colorScheme.tertiary)),
                          )),
                    )
                  : const SizedBox();
                }),
                const SizedBox(
                  height: 40,
                ),
                Consumer<AnswerProvider>(
                  builder: (context, answerProvider, _) {
                    if (answerProvider.isqsattempted == 1) {
                      if (ansresult == 1) {
                        return  Text('Correct answer',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: theme.colorScheme.secondary)
                        ),
                        );
                      } else {
                        return Column(
                          children: [
                             Text('Wrong answer',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Color.fromARGB(255, 162, 52, 44))
                            ),
                            ),
                            Text(
                              'Correct answer: ${exercise['answer${index}']}',
                              style: TextStyle(color: theme.colorScheme.tertiary),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 20,),
                index == 3
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                theme.colorScheme.secondary),
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width, 50))),
                        onPressed: () {
                          String currentDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          FirebaseFirestore.instance
                              .collection(
                                  'users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
                              .doc('${currentDate}')
                              .update({'isAttempted': true, 'score': _score*10});
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ResultPage()));
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(color: theme.colorScheme.tertiary)),
                        ))
                    : const SizedBox()
              ],
            )),
      ),
    );
  }
}
