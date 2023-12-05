import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:memory_aid/widget/pricePoint.dart';

class MLineChartWidget extends StatelessWidget {
  final Future<List<PricePoint>> futurePoints;

  const MLineChartWidget({Key? key, required this.futurePoints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<PricePoint>>(
      future: futurePoints,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          List<PricePoint> points = snapshot.data!;
          
          return AspectRatio(
        aspectRatio: 2,
        child: LineChart(LineChartData(
            titlesData: FlTitlesData(
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      'Points',
                      style: TextStyle(color: theme.colorScheme.tertiary),
                    ),
                    sideTitles:const SideTitles(reservedSize: 22)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('W1',
                          style: TextStyle(color: theme.colorScheme.tertiary));
                      case 1:
                        return Text('W2',
                            style:
                                TextStyle(color: theme.colorScheme.tertiary));
                      case 2:
                        return Text('W3',
                            style:
                                TextStyle(color: theme.colorScheme.tertiary));
                      case 3:
                        return Text('W4',
                            style:
                                TextStyle(color: theme.colorScheme.tertiary));
                      case 4:
                        return Text('W5',
                            style:
                                TextStyle(color: theme.colorScheme.tertiary));
                      case 5:
                        return Text('W6',
                            style:
                                TextStyle(color: theme.colorScheme.tertiary));
                      
                      default:
                        return const Text('');
                    }
                  },
                ))),
            gridData: const FlGridData(show: true, horizontalInterval: 10),
            lineBarsData: [
              LineChartBarData(
                  spots:
                      points.map((point) => FlSpot(point.x, point.y)).toList(),
                  isCurved: false,
                  dotData: const FlDotData(show: true),
                  color: theme.colorScheme.secondary)
            ])));
        }
      },
    );
  }
}

