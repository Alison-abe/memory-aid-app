import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryProvider with ChangeNotifier {
  String? _selectedDate;
  String _selectedSummary = '';

  String? get selectedDate => _selectedDate;
  String? get selectedSummary => _selectedSummary;

  void setselectedDate(String? value) {
    _selectedDate = value;
    notifyListeners();
  }

  void initselectedDate(String? value) {
    _selectedDate = value;
  }

  void initselectedSummary(String value) {
    _selectedSummary = value;
  }

  void setselectedSummary(String value) {
    _selectedSummary = value;
    notifyListeners();
  }

  String apiUrl =
      "https://api-inference.huggingface.co/models/potsawee/t5-large-generation-squad-QuestionAnswer";
  Map<String, String> headers = {
    "Authorization": "Bearer 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",
  };

  Future<String> questionQuery(Map<String, dynamic> payload) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(payload));
    print(response.body);
    final output = jsonDecode(response.body);
    return output[0]['generated_text'];
  }

  final summaryapiUrl =
      "https://api-inference.huggingface.co/models/naisel/pegasus-with-samsum-dataset";
  final summaryheaders = {
    "Authorization": "Bearer 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",
  };
  Future<String> Summaryquery(Map<String, dynamic> payload) async {
    final response = await http.post(Uri.parse(summaryapiUrl),
        headers: summaryheaders, body: jsonEncode(payload));
    final output = jsonDecode(response.body);
    String output_summary = output[0]['generated_text'];
    List<String> splited_summary = output_summary.split(".");
    for (int i = 0; i < splited_summary.length - 1; i++) {
      String Qoutput = await questionQuery({
        "inputs": splited_summary[i],
      });
      List<String> parts = Qoutput.split("?");
      String question = parts[0].trim();
      String answer = parts[1].trim();
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      FirebaseFirestore.instance
          .collection(
              'users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
          .doc('${currentDate}')
          .set({'question${i+1}': question, 'answer${i+1}': answer},SetOptions(merge: true));

      print("question part : " + question);
      print(answer);
    }

    print(output[0]['generated_text']);
    return output[0]['generated_text'];
  }
}
