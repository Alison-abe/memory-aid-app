import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class PricePoint {
  final double x;
  final double y;
  PricePoint({required this.x, required this.y});
}


List<double> monthlypoints = [0.0,0.0,0.0,0.0,0.0,0.0];

Future<List<PricePoint>> get monthly_pricePoints async {
  return monthlypoints
      .mapIndexed(
          ((index, element) => PricePoint(x: index.toDouble(), y: element)))
      .toList();
}

int getWeekNumberWithinMonth(DateTime date) {
    // Find the first day of the month
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    // Calculate the difference in weeks
    int weekDifference = date.difference(firstDayOfMonth).inDays ~/ 7;

    // Week number within the month (add 1 to make it human-readable)
    return weekDifference + 1;
  }


int weekNumber=0;

Future<List<PricePoint>> get pricePoints async {
  int weekint = DateTime.now().weekday;
  // int monthint = DateTime.now().month;
  print(weekint.runtimeType);
  DateTime currweek = DateTime.now();
  List<double> datapoints = [0.0,0.0,0.0,0.0,0.0,0.0,0.0];
  while (weekint > 0)  {
   String currentDate = DateFormat('yyyy-MM-dd').format(currweek);
   DateTime date = DateFormat("yyyy-MM-dd").parse(currentDate);
   weekNumber = getWeekNumberWithinMonth(date);
    final data;
    final textId = FirebaseFirestore.instance
                .collection(
                    'users/${FirebaseAuth.instance.currentUser!.uid}/exercise')
                .doc(currentDate);
            DocumentSnapshot snapshot = await textId.get();
            data = snapshot.data();
            int _score = data?['score'] as int;
    datapoints[weekint-1]=_score.toDouble() ;
    weekint--;
    currweek = currweek.subtract(const Duration(days: 1));
  }

  if(DateTime.now().weekday==7) {
    monthlypoints[weekNumber-1] += datapoints.reduce((value, element) => value + element);
  }



  return datapoints
      .mapIndexed(
          ((index, element) => PricePoint(x: index.toDouble(), y: element)))
      .toList();
}
