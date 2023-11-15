import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memory_aid/provider/signin_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../provider/profile_provider.dart';
import '../provider/summary_provider.dart';
import '../widget/navbars/bottom_navbar.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Provider.of<SummaryProvider>(context, listen: false).selectedDate ==
                null;
            if (!Provider.of<GoogleSignInProvider>(context, listen: false)
                .isNewUser) {
              Provider.of<ProfileProvider>(context, listen: false)
                  .addProfile(UserProfile(
                uid: '',
                age: '',
                phNo: '',
                ctname: '',
                ctphno: '',
                ctemail: '',
              ));
            }
            String currentDate =
                DateFormat('yyyy-MM-dd').format(DateTime.now());
            Future<void> setExercise() async {
              final DocumentSnapshot snapshot = await FirebaseFirestore.instance
                  .collection(
                      'users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
                  .doc('${currentDate}')
                  .get();
              print("inside excerise creation1");
              if (!snapshot.exists) {
                print("inside excerise creation2");
                FirebaseFirestore.instance
                    .collection(
                        'users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
                    .doc('${currentDate}')
                    .set({'isAttempted': false, 'score': 0});
              }
            }

            setExercise();
            return const BottomNavBar();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
