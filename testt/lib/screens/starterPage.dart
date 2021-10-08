
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testt/common/movegraph.dart';

import 'package:testt/screens/tradelist.dart';
import 'package:testt/utils/toolsUtilities.dart';


import 'dashpage.dart';
import 'note_buy.dart';




class StarterPage extends StatefulWidget {
  @override
  _StarterPageState createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {

  @override
  void initState() {
    super.initState();

    // 풀스크린 만들기 현재 상태바만 없앤 상태.
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {


    List<Widget> tabs = [
      TradeList(),
      NoteBuy(),
      MoveGraph(),
      DashPage()
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home,color: ToolsUtilities.whiteColor, size: 20,),
          Icon(Icons.text_snippet,color: ToolsUtilities.whiteColor, size: 20,),
          Icon(Icons.trending_up,color: ToolsUtilities.whiteColor, size: 20),
          Icon(Icons.dashboard,color: ToolsUtilities.whiteColor, size: 20),
        ],
        color: ToolsUtilities.secondColor,
        buttonBackgroundColor: ToolsUtilities.secondColor,
        backgroundColor: ToolsUtilities.whiteColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds:200),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: tabs[_page],
    );
  }
}
