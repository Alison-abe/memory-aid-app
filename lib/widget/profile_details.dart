
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsTile extends StatelessWidget {
  final String title;
  final String details;
  const DetailsTile({super.key,required this.title,required this.details});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(title,
          overflow: TextOverflow.visible,
          style: GoogleFonts.poppins(
            textStyle:TextStyle(fontWeight: FontWeight.bold,color:theme.colorScheme.tertiary ,fontSize: 15),
          ),
          ),
          const SizedBox(width: 15,),
          Text(details,
          overflow: TextOverflow.visible,
          style: GoogleFonts.poppins(
            textStyle:TextStyle(color:theme.colorScheme.tertiary ,fontSize: 14),
          ),)
        ],
      ),
    );
  }
}