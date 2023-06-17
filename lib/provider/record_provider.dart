
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:http/http.dart' as http;

class RecordProvider with ChangeNotifier{
  FlutterSoundRecorder _recorder= FlutterSoundRecorder();
    String _filePath ='/sdcard/Download/audio.wav';
    final String apiUrl = "https://api-inference.huggingface.co/models/openai/whisper-large-v2";
  final Map<String, String> headers = {"Authorization": "Bearer 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"};
    Future<void> startRecording() async {
      print('started');
    try {
      Directory directory = Directory(path.dirname(_filePath));
    if (!directory.existsSync()) {
      directory.createSync();
    }

      await _recorder.openRecorder();
      await _recorder.startRecorder(toFile: _filePath);
     
    } catch (e) {
      print('Failed to start recording: $e');
    }
  }

 Future<String> query(String filename) async {
  File file = File(filename);
  List<int> data = await file.readAsBytes();
  var response = await http.post(Uri.parse(apiUrl), headers: headers, body: data);
  Map<String, dynamic> result = jsonDecode(response.body);
  return result["text"];
}

Future<void> stopRecording() async {
  print('stoped');
    try {
      await _recorder.stopRecorder();
      await _recorder.closeRecorder();
     final output = await query(_filePath);
     print(output);
    } catch (e) {
      print('Failed to stop recording: $e');
    }
  }


}