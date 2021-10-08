import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/modal_class/notes.dart';

class Chart extends StatefulWidget {
  BarChart createState() => BarChart();
}

class BarChart extends State<Chart> {

  @override
  Widget build(BuildContext context) {
    DatabaseBuy().getNoteList2().then((value) => value.forEach((element) async{
          // print('${element.total}\n${element.date}');
          print(element.total);
          await box.write('listdata', element.date);
          await box.write('listdata2', element.total);
          // print(box.read('listdata').values);
        }));
    final List<SalesData> chartData = [

      SalesData(
          // DateTime.parse(DateFormat('yyyy-mm-dd')
          //     .parse(box.read('listdata'))
          //     .toIso8601String()),
          DateTime.parse(DateFormat('yy').parse('2024').toIso8601String()),
          double.parse(box.read('listdata2').toString())),
      // SalesData(DateTime.parse(DateFormat('yy').parse('2024').toIso8601String()), 34),
      // SalesData(DateTime.parse(DateFormat('yyyy').parse('2025').toIso8601String()), 32),
      // SalesData(DateTime.parse(DateFormat('yyyy').parse('2036').toIso8601String()), 40)
    ];
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                series: <ChartSeries>[
                  // Renders line chart
                  LineSeries<SalesData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales)
                ])));
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
