import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory_aid/provider/answer_provider.dart';
import 'package:memory_aid/provider/exercise_provider.dart';
import 'package:memory_aid/provider/note_provider.dart';
import 'package:memory_aid/provider/profile_provider.dart';
import 'package:memory_aid/provider/record_provider.dart';
import 'package:memory_aid/provider/search_provider.dart';
import 'package:memory_aid/provider/signin_provider.dart';
import 'package:memory_aid/provider/summary_provider.dart';
import 'package:memory_aid/screens/home_screen.dart';
import 'package:memory_aid/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
      [
        ChangeNotifierProvider(
          create: (BuildContext context)=> GoogleSignInProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> ProfileProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> RecordProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> NoteProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> SummaryProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> ExerciseProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> AnswerProvider()),
        ChangeNotifierProvider(
          create: (BuildContext context)=> SearchProvider()),
      ],
      child: MaterialApp(
      title: 'Memory Aid',
      theme: ThemeData(
        colorScheme:const ColorScheme.light(
          primary:  Color.fromARGB(255, 42, 41, 41),
          //Color.fromARGB(255, 45, 44, 44),
          secondary: Color.fromARGB(255, 117, 162, 139),
          tertiary: Colors.white,
          secondaryContainer: Color.fromARGB(255, 153, 194, 172)
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoadApp(),

    ),
    );
  }
}

class LoadApp extends StatelessWidget {
  const LoadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: Future.delayed(
        const Duration(seconds: 2),
      ),
      builder: (context, snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return const SplashScreen();
        } else {
          return const HomeScreen();
        }
      },
    );
}

}