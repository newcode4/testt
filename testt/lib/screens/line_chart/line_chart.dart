import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/modal_class/notes.dart';




class LineChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  LineChart({Key key}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}



class _LineChartState extends State<LineChart> {


      @override
    void initState()  {
        super.initState();
        asyncMethod();

  }

      void asyncMethod()  async{
         DatabaseBuy databaseHelper = DatabaseBuy();

        Future<Database> dbFuture = databaseHelper.initializeDatabase();
         await dbFuture.then((database) {
          Future<List<Note>> noteListFuture = databaseHelper.getNoteList2();
          noteListFuture.then((noteList) {
            var filterList = noteList;
            for (int i = filterList.length-1; i >= 0; i--) {
              test.add(noteList[i]);

            }

            return money.write('note',test);
          });});

      }

  List<Note> data = money.read('note');
      List<Note> test = [];




  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: const Text('라인 그래프'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          Container(
            height: 600,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: '당신의 수익금'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true, ),
                series: <ChartSeries<Note, String>>[
                  LineSeries<Note, String>(
                      dataSource: data,
                      xValueMapper: (Note sales, _) => sales.date,
                      yValueMapper: (Note sales, _) => int.parse(sales.total),
                      name: '수익금',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true,
                      )
                  )
                ]),
          ),

        ]));
  }
}
