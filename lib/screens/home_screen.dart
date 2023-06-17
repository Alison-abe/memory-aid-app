import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/provider/signin_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../provider/profile_provider.dart';
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
            if (!Provider.of<GoogleSignInProvider>(context, listen: false)
                .isNewUser) {
              Provider.of<ProfileProvider>(context, listen: false).addProfile(
                  UserProfile(
                      uid: '',
                      age: '',
                      phNo: '',
                      ctname: '',
                      ctphno: '',
                      ctemail: '',
                      ));
            }
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
