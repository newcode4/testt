// import 'package:bezier_chart/bezier_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:sqflite/sqflite.dart';
// import 'package:testt/db_helper/db_helper.dart';
// import 'package:testt/modal_class/notes.dart';
// import 'package:jiffy/jiffy.dart';
//
// class BarChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   _onTap(BuildContext context, Widget widget) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           appBar: AppBar(),
//           body: widget,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("라인 그래프",),
//           centerTitle: true,
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black54,
//                 Colors.black87,
//                 Colors.black87,
//                 Colors.black,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildChart(
//                 BezierChartScale.YEARLY,
//                 context,
//                 LinearGradient(
//                   colors: [
//                     Colors.blueAccent,
//                     Colors.blueAccent[400],
//                     Colors.lightBlue[400],
//                     Colors.lightBlue[500],
//                     Colors.blue,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               )
//             ],
//           ),
//         )
//     );
//   }
// }
// _buildChart(BezierChartScale scale, BuildContext context, LinearGradient gradient) {
//   var fromDate = DateTime(2021, 05, 22);
//   var toDate = DateTime.now();
//   var date1 = DateTime.now().subtract(Duration(days: 2));
//   var date2 = DateTime.now().subtract(Duration(days: 3));
//
//   DatabaseBuy databaseHelper = DatabaseBuy();
//   Future<Database> dbFuture = databaseHelper.initializeDatabase();
//   dbFuture.then((database) {
//     Future<List<Note>> noteListFuture = databaseHelper.getNoteList2();
//     noteListFuture.then((noteList ) {
//
//       String moon = Jiffy('${noteList[0].date}').format('yy-MM-dd');
//
//       print(DateTime.tryParse('${Jiffy('${noteList[0].date}').format('yy-MM-dd')}'));
//       // print(DateFormat('yyyy-MM-dd').format(noteList[0].date as DateTime));
//       toDate = DateTime.now();
//       date1 = DateTime.now().subtract(Duration(days: 2));
//       date2 = DateTime.now().subtract(Duration(days: 3));
//     });
//   });
//   return Center(
//       child: Card(
//           elevation: 10,
//           margin: EdgeInsets.all(15.0),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.black54,
//                   Colors.black87,
//                   Colors.black87,
//                   Colors.black,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "수익률",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Center(
//                   child: Card(
//                     elevation: 12,
//                     child: Container(
//                       height: MediaQuery
//                           .of(context)
//                           .size
//                           .height / 2,
//                       width: MediaQuery
//                           .of(context)
//                           .size
//                           .width * 0.9,
//                       child: BezierChart(
//                         fromDate: fromDate,
//                         bezierChartScale: BezierChartScale.WEEKLY,
//                         toDate: toDate,
//                         onIndicatorVisible: (val) {
//                           print("Indicator Visible :$val");
//                         },
//                         onDateTimeSelected: (datetime) {
//                           print("selected datetime: $datetime");
//                         },
//                         onScaleChanged: (scale) {
//                           print("Scale: $scale");
//                         },
//                         selectedDate: toDate,
//                         //this is optional
//                         footerDateTimeBuilder: (DateTime value,
//                             BezierChartScale scaleType) {
//                           final newFormat = intl.DateFormat('yy/MM/dd');
//                           return newFormat.format(value);
//                         },
//                         series: [
//
//                           BezierLine(
//                             label: "Flight",
//                             lineColor: Colors.white,
//                             onMissingValue: (dateTime) {
//                               if (dateTime.day.isEven) {
//                                 return 10.0;
//                               }
//                               return 5.0;
//                             },
//                             data: <DataPoint<DateTime>>[
//                               DataPoint<DateTime>(value: 20, xAxis: date1),
//                               DataPoint<DateTime>(value: 30, xAxis: date2),
//                             ],
//                           ),
//                         ],
//                         config: BezierChartConfig(
//                           startYAxisFromNonZeroValue: false,
//                           displayDataPointWhenNoValue: false,
//                           bubbleIndicatorColor: Colors.white.withOpacity(
//                               0.9),
//                           footerHeight: 40,
//                           physics: ClampingScrollPhysics(),
//                           verticalIndicatorStrokeWidth: 3.0,
//                           verticalIndicatorColor: Colors.black26,
//                           showVerticalIndicator: true,
//                           verticalIndicatorFixedPosition: false,
//                           displayYAxis: true,
//                           stepsYAxis: 10,
//                           backgroundGradient: LinearGradient(
//                             colors: [
//                               Colors.blueAccent,
//                               Colors.blueAccent[400],
//                               Colors.lightBlue[400],
//                               Colors.lightBlue[500],
//                               Colors.blue,
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           snap: true,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )));
//
// }
//
