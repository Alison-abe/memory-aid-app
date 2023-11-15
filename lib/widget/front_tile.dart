import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrontTile extends StatelessWidget {
  final String title,subtitle;
  const FrontTile({required this.title,required this.subtitle,super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            //color: theme.colorScheme.secondary
            gradient:const LinearGradient(
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                 style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: theme.colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                  )
                 ),
                ),
                Text(subtitle,
                 style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: theme.colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                  )
                 ),
                )
              ],
            ),
          )
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Image.asset('assets/images/drink.jpg',height: 170,width: 100,),
        // )
      ],
    );
  }
}