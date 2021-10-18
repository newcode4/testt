import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';


//월별 그래프

class BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  _onTap(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: widget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("라인 그래프",),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black54,
                Colors.black87,
                Colors.black87,
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Bezier Chart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),

              _buildChart(
                BezierChartScale.YEARLY,
                context,
                LinearGradient(
                  colors: [
                    Colors.red[300],
                    Colors.red[400],
                    Colors.red[400],
                    Colors.red[500],
                    Colors.red,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            ],
          ),
        )
    );
  }
}
_buildChart(BezierChartScale scale, BuildContext context,
    LinearGradient gradient) {
  final fromDate = DateTime(2018, 11, 22);
  final toDate = DateTime.now();

  final date1 = DateTime.now().subtract(Duration(days: 2));
  final date2 = DateTime.now().subtract(Duration(days: 3));

  final date3 = DateTime.now().subtract(Duration(days: 2));
  final date4 = DateTime.now().subtract(Duration(days: 2));

  final date5 = DateTime.now().subtract(Duration(days: 2));
  final date6 = DateTime.now().subtract(Duration(days: -6));

  return Center(
      child: Card(
          elevation: 10,
          margin: EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.black87,
                  Colors.black87,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Bezier Chart - Numbers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 12,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: BezierChart(
                        bezierChartScale: BezierChartScale.MONTHLY,
                        fromDate: fromDate,
                        toDate: toDate,
                        selectedValue: 30,
                        xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                        footerValueBuilder: (double value) {
                          return "${formatAsIntOrDouble(value)}\ndays";
                        },
                        series: [
                          BezierLine(
                            label: "Duty",
                            data: <DataPoint<DateTime>>[
                              DataPoint<DateTime>(value: 10, xAxis: date1),
                              DataPoint<DateTime>(value: 50, xAxis: date2),
                              DataPoint<DateTime>(value: 10, xAxis: date3),
                              DataPoint<DateTime>(value: 10, xAxis: date4),
                              DataPoint<DateTime>(value: 40, xAxis: date5),
                              DataPoint<DateTime>(value: 47, xAxis: date6),

                            ],
                          ),
                          BezierLine(
                            label: "Flight",
                            lineColor: Colors.black26,
                            onMissingValue: (dateTime) {
                              if (dateTime.month.isEven) {
                                return 10.0;
                              }
                              return 3.0;
                            },
                            data: <DataPoint<DateTime>>[
                              DataPoint<DateTime>(value: 20, xAxis: date1),
                              DataPoint<DateTime>(value: 30, xAxis: date2),
                              DataPoint<DateTime>(value: 15, xAxis: date3),
                              DataPoint<DateTime>(value: 80, xAxis: date4),
                              DataPoint<DateTime>(value: 45, xAxis: date5),
                              DataPoint<DateTime>(value: 45, xAxis: date6),
                            ],
                          ),
                        ],
                        config: BezierChartConfig(
                          startYAxisFromNonZeroValue: false,
                          bubbleIndicatorColor: Colors.white.withOpacity(0.9),
                          footerHeight: 40,
                          verticalIndicatorStrokeWidth: 3.0,
                          verticalIndicatorColor: Colors.black26,
                          showVerticalIndicator: true,
                          verticalIndicatorFixedPosition: false,
                          displayYAxis: true,
                          stepsYAxis: 10,
                          backgroundGradient: LinearGradient(
                            colors: [
                              Colors.red[300],
                              Colors.red[400],
                              Colors.red[400],
                              Colors.red[500],
                              Colors.red,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          snap: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )));
}

//SAMPLE CUSTOM VALUES
Widget sample1(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.black54,
          Colors.black87,
          Colors.black87,
          Colors.black,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Bezier Chart - Numbers",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        Center(
          child: Card(
            elevation: 12,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width * 0.9,
              child: BezierChart(
                bezierChartScale: BezierChartScale.MONTHLY,
                selectedValue: 30,
                xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                footerValueBuilder: (double value) {
                  return "${formatAsIntOrDouble(value)}\ndays";
                },
                series: const [
                  BezierLine(
                    label: "m",
                    data: const [
                      DataPoint<double>(value: 10, xAxis: 0),
                      DataPoint<double>(value: 130, xAxis: 5),
                      DataPoint<double>(value: 50, xAxis: 10),
                      DataPoint<double>(value: 150, xAxis: 15),
                      DataPoint<double>(value: 75, xAxis: 20),
                      DataPoint<double>(value: 0, xAxis: 25),
                      DataPoint<double>(value: 5, xAxis: 30),
                      DataPoint<double>(value: 45, xAxis: 35),
                    ],
                  ),
                ],
                config: BezierChartConfig(
                  startYAxisFromNonZeroValue: false,
                  bubbleIndicatorColor: Colors.white.withOpacity(0.9),
                  footerHeight: 40,
                  verticalIndicatorStrokeWidth: 3.0,
                  verticalIndicatorColor: Colors.black26,
                  showVerticalIndicator: true,
                  verticalIndicatorFixedPosition: false,
                  displayYAxis: true,
                  stepsYAxis: 10,
                  backgroundGradient: LinearGradient(
                    colors: [
                      Colors.red[300],
                      Colors.red[400],
                      Colors.red[400],
                      Colors.red[500],
                      Colors.red,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  snap: true,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}