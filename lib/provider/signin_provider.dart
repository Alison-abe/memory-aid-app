import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool _isNewUser = true;
  GoogleSignInAccount? get user => _user;
  bool get isNewUser => _isNewUser; 

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    Future<bool> isNewUserMethod(String email) async {
      try {
        final methods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
            notifyListeners();
        return methods.isNotEmpty;
      } catch (e) {
        return false;
      }
    }

    _isNewUser = await isNewUserMethod(googleUser.email);
    
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }




    

}
