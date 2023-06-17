import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/signin_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding:const EdgeInsets.only(top:60,left: 20,right: 20,bottom: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Memory Aid ",style: GoogleFonts.manrope(
                  textStyle: TextStyle(color: theme.colorScheme.secondary,fontSize: 40,fontWeight: FontWeight.w800)
                ),),
                const SizedBox(height: 20,),
                Text("Rediscover the joy  ",style: GoogleFonts.poppins(
                  textStyle: TextStyle(color:theme.colorScheme.tertiary,fontSize: 20)
                ),),
                Text("of Remembering ",style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: theme.colorScheme.tertiary,fontSize: 20)
                ),),
                const SizedBox(height: 40,),
                Image.asset('assets/images/login.png'),
                const SizedBox(height: 30,),
                SizedBox(                 
                  height: 63,
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const BottomNavBar()));
                      final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                      provider.googleLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      backgroundColor:theme.colorScheme.secondary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         SizedBox(
                          height: 20,
                          width: 25,
                          child: FaIcon(FontAwesomeIcons.google,color: theme.colorScheme.tertiary,)
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Text(
                          'Sign up with Google',
                          style: GoogleFonts.roboto(
                            textStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: theme.colorScheme.tertiary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(fontSize: 14,color: theme.colorScheme.tertiary),)
                    ),
                    InkWell(
                      onTap: () {
                        final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                        provider.googleLogin();
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.manrope(
                          textStyle:  TextStyle(
                              fontSize: 14,
                              color:  theme.colorScheme.secondary,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
              ],
            ),
              ]
          ),
          )
          ),
        )
      )
    );
  }
}