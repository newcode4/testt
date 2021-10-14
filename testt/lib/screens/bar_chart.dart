import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/db_helper/db_helper.dart';


class Chart extends StatefulWidget {
  BarChart createState() => BarChart();
}

class BarChart extends State<Chart> {
  List Data = ['1','2','3','4','5','6','7','8','9','10','11','12'];
  List Data2 = ['0','0','0','0','0','0','0','0','0','0','0','0',];


  @override
  Widget build(BuildContext context) {

    DatabaseBuy().getMonth().then((value) => value.forEach((element) async{

      var _toDay = DateTime.now();

      var tt = DateFormat('M').format(_toDay).toString();
      int count = int.parse(tt);
      print((element.values.elementAt(0).toString()));

      Data2[0]= (element.values.elementAt(0).toString());
      Data2[1]= (element.values.elementAt(0).toString());
      Data2[2]= (element.values.elementAt(0).toString());
      Data2[3]= (element.values.elementAt(0).toString());
      Data2[4]= (element.values.elementAt(0).toString());
      Data2[5]= (element.values.elementAt(0).toString());
      Data2[6]= (element.values.elementAt(0).toString());
      Data2[7]= (element.values.elementAt(0).toString());
      Data2[8]= (element.values.elementAt(0).toString());
      Data2[9]= (element.values.elementAt(0).toString());
      Data2[10]= (element.values.elementAt(0).toString());
      Data2[11]= (element.values.elementAt(0).toString());



          // print('${element.total}\n${element.date}');
          print("data :  $Data \n data2 : $Data2");
          // await box.write('listdata', element.date);
          // await box.write('listdata2', element.total);

          // print(box.read('listdata').values);
        }));

  List<SalesData> chartData = [


      // SalesData(DateTime.parse(DateFormat('yyyy').parse(Data[0]).toIso8601String()), int.parse(Data2[0])),
      // SalesData(DateTime.parse(DateFormat('yyyy').parse('2025').toIso8601String()), int.parse(Data2[1])),
      // SalesData(DateTime.parse(DateFormat('yyyy').parse('2026').toIso8601String()), int.parse(Data2[3])),
    SalesData(DateTime.parse(DateFormat('M').parse('1').toIso8601String()),int.parse(Data2[0])),
    SalesData(DateTime.parse(DateFormat('M').parse('2').toIso8601String()),int.parse(Data2[1])),
    SalesData(DateTime.parse(DateFormat('M').parse('3').toIso8601String()),int.parse(Data2[2])),
    SalesData(DateTime.parse(DateFormat('M').parse('4').toIso8601String()),int.parse(Data2[3])),
    SalesData(DateTime.parse(DateFormat('M').parse('5').toIso8601String()),int.parse(Data2[4])),
    SalesData(DateTime.parse(DateFormat('M').parse('6').toIso8601String()),int.parse(Data2[5])),
    SalesData(DateTime.parse(DateFormat('M').parse('7').toIso8601String()),int.parse(Data2[6])),
    SalesData(DateTime.parse(DateFormat('M').parse('8').toIso8601String()),int.parse(Data2[7])),
    SalesData(DateTime.parse(DateFormat('M').parse('9').toIso8601String()),int.parse(Data2[8])),
    SalesData(DateTime.parse(DateFormat('M').parse('10').toIso8601String()),int.parse(Data2[9])),
    SalesData(DateTime.parse(DateFormat('M').parse('11').toIso8601String()),int.parse(Data2[10])),
    SalesData(DateTime.parse(DateFormat('M').parse('12').toIso8601String()),int.parse(Data2[11])),


      // SalesData(
      //   // DateTime.parse(DateFormat('yyyy-mm-dd')
      //   //     .parse(box.read('listdata'))
      //   //     .toIso8601String()),
      //     DateTime.parse(DateFormat('yyyy').parse('2027').toIso8601String()),
      //     int.parse(box.read('listdata2').toString())),

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
  final int sales;
}
