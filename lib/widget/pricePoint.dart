import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PricePoint {
  final double x;
  final double y;
  PricePoint({required this.x, required this.y});
}

Future<List<PricePoint>> get pricePoints async {
  int weekint = DateTime.now().weekday;
  print(weekint.runtimeType);
  DateTime currweek = DateTime.now();
  List<double> datapoints = [0.0,0.0,0.0,0.0,0.0,0.0,0.0];
  while (weekint > 0)  {
   String currentDate = DateFormat('yyyy-MM-dd').format(currweek);
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



  return datapoints
      .mapIndexed(
          ((index, element) => PricePoint(x: index.toDouble(), y: element)))
      .toList();
}
