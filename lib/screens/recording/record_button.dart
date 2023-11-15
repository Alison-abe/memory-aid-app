import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_aid/provider/record_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({super.key});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

bool _isrecording = false;
void initializer() async{
  await Permission.microphone.request();
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
}
class _RecordButtonState extends State<RecordButton> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();

  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Column(
      children:[ AvatarGlow(
          animate: _isrecording,
          endRadius: 85,
          glowColor: theme.colorScheme.tertiary,
          child: GestureDetector(
            onTap: () {
              final provider=Provider.of<RecordProvider>(context,listen:false);
              _isrecording ? provider.stopRecording() :provider.startRecording() ;
              setState(() {
                _isrecording=!_isrecording;
              });
              
            },  
            child: CircleAvatar(
              backgroundColor:const Color.fromARGB(255, 56, 93, 88),
              radius: 50,
              child: Icon(
                _isrecording ? Icons.mic : Icons.mic_none,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ),
        ),
        Text(
          _isrecording ? "Recording your conversations..." : "Tap to record the conversations",
          style: GoogleFonts.manrope(
            color: theme.colorScheme.secondary,
            textStyle: const TextStyle(fontSize: 17)
          ),
        ),
        
        ],
    );
    
  }
}
