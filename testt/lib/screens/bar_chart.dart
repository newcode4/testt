import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/modal_class/notes.dart';




class BarChart extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    // DatabaseBuy().getMonth().then((value) => value.forEach((element) {
    //   print(element.values);

    final List<SalesData> chartData = [
      // SalesData(DateTime.parse(DateFormat('yyyy').parse(element.values.last.toString()).toIso8601String()), double.parse(element.values.first.toString())),
      SalesData(DateTime.parse(DateFormat('yy').parse('2024').toIso8601String()), 34),
      SalesData(DateTime.parse(DateFormat('yyyy').parse('2025').toIso8601String()), 32),
      SalesData(DateTime.parse(DateFormat('yyyy').parse('2036').toIso8601String()), 40)
    ];

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<SalesData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales
                      )
                    ]
                )
            )
        )
    );
    // }));
  }
}
  class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
  }