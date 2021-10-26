import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/modal_class/notes.dart';
import 'package:testt/screens/line_chart/line_chart.dart';
import 'package:testt/utils/toolsUtilities.dart';

class BarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BarChart({Key key}) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  ZoomPanBehavior _zoomPanBehavior;
  SelectionBehavior _selectionBehavior;


  @override
  void initState() {

    _selectionBehavior =  SelectionBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );

    day();
    monthday();
    yearday();
    super.initState();
  }

  void day() async {
    DatabaseBuy databaseHelper = DatabaseBuy();

    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    await dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList3();
      noteListFuture.then((noteList) {
        var filterList = noteList;
        for (int i = 0; i < filterList.length ; i++) {
          test.add(noteList[i]);
        }
        return money.write('note', test);
      });
    });
  }

  void monthday() async {
    DatabaseBuy databaseHelper = DatabaseBuy();

    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    await dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList4();
      noteListFuture.then((noteList) {

        var filterList = noteList;
        test=[];
        for (int i = 0; i < filterList.length ; i++) {

          test.add(noteList[i]);
        }


        return money.write('note_month', test);
      });
    });
  }

  void yearday() async {
    DatabaseBuy databaseHelper = DatabaseBuy();

    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    await dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList3();
      noteListFuture.then((noteList) {
        test=[];
        var filterList = noteList;
        for (int i = 0; i < filterList.length ; i++) {
          test.add(noteList[i]);
        }

        return money.write('note_year', test);
      });
    });
  }

  List<Note> data = money.read('note');
  List<Note> month_data = money.read('note_month');
  List<Note> year_data = money.read('note_year');
  List<Note> test = [];


  var tab = true? LineSeries : ColumnSeries;


  Widget myAppBar() {
    return AppBar(
      title: const Text('막대 그래프'),
      centerTitle: true,
      bottom: TabBar(
        indicatorColor: Colors.black,
        tabs: <Widget>[
          Tab(
            child: Text('일', style: TextStyle(color: Colors.black)),
          ),
          Tab(
            child: Text('월', style: TextStyle(color: Colors.black)),
          ),
          Tab(
            child: Text('년', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: myAppBar(),

        body: TabBarView(children: <Widget>[
          DrawChartDay(context, f),
          DrawChartMonth(context, f),
          DrawChartYear(context, f),

        ]),
      ),
    );
  }

  Column DrawChartDay(BuildContext context, NumberFormat f) {
    return Column(children: [
      //Initialize the chart widget
      Container(
        width: MediaQuery.of(context).size.width,
        height:490,
        child: SfCartesianChart(
            onSelectionChanged: (SelectionArgs args){
              args.selectedColor = Colors.red;
              args.unselectedColor = Colors.lightBlue;
            },
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: '--당신의 수익금--'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x\n\n'
                    'point.y원'

            ),
            series: <ChartSeries<Note, String>>[
              ColumnSeries<Note, String>(
                  dataSource: data,
                  xValueMapper: (Note sales, _) => sales.date,
                  yValueMapper: (Note sales, _) => int.parse(sales.total),
                  dataLabelMapper: (Note sales, _) => '${f.format(int.parse(sales.total))}원',
                  selectionBehavior: _selectionBehavior,
                  markerSettings: MarkerSettings(
                      isVisible: true
                  ),
                  name: '수익금',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true
                  ))
            ]),
      ),
      SizedBox(height: 15,),
    

    ]);
  }
  Column DrawChartMonth(BuildContext context, NumberFormat f) {
    return Column(children: [
      //Initialize the chart widget
      Container(
        width: MediaQuery.of(context).size.width,
        height: 490,
        child: SfCartesianChart(
            onSelectionChanged: (SelectionArgs args){
              args.selectedColor = Colors.red;
              args.unselectedColor = Colors.lightBlue;
            },
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: '--당신의 수익금--'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x\n\n'
                    'point.y원'

            ),
            series: <ChartSeries<Note, String>>[
              ColumnSeries<Note, String>(
                  dataSource: month_data,
                  xValueMapper: (Note sales, _) => sales.date,
                  yValueMapper: (Note sales, _) => int.parse(sales.total),
                  dataLabelMapper: (Note sales, _) => '${f.format(int.parse(sales.total))}원',
                  selectionBehavior: _selectionBehavior,
                  markerSettings: MarkerSettings(
                      isVisible: true
                  ),
                  name: '수익금',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true
                  ))
            ]),
      ),
      SizedBox(height: 15,),

    ]);
  }
  Column DrawChartYear(BuildContext context, NumberFormat f) {
    return Column(children: [
      //Initialize the chart widget
      Container(
        width: MediaQuery.of(context).size.width,
        height: 490,
        child: SfCartesianChart(
            onSelectionChanged: (SelectionArgs args){
              args.selectedColor = Colors.red;
              args.unselectedColor = Colors.lightBlue;
            },
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: '--당신의 수익금--'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x\n\n'
                    'point.y원'

            ),
            series: <ChartSeries<Note, String>>[
              ColumnSeries<Note, String>(
                  dataSource: year_data,
                  xValueMapper: (Note sales, _) => sales.date,
                  yValueMapper: (Note sales, _) => int.parse(sales.total),
                  dataLabelMapper: (Note sales, _) => '${f.format(int.parse(sales.total))}원',
                  selectionBehavior: _selectionBehavior,
                  markerSettings: MarkerSettings(
                      isVisible: true
                  ),
                  name: '수익금',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true
                  ))
            ]),
      ),
      SizedBox(height: 15,),


    ]);
  }
}
