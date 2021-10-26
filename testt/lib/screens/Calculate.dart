import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:testt/common/SpnnerControl.dart';
import 'package:testt/modal_class/LoanInfo.dart';
import 'package:testt/utils/ToastUtils.dart';
import 'package:testt/utils/calc.dart';
import 'package:testt/utils/utils.dart';

import 'RateParentPage.dart';

class Calculate extends StatelessWidget {
  bool isOK = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '계산기',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyLoadPage(title: "계산기",),
    );
  }
}

class MyLoadPage extends StatefulWidget {
  final String title;

  MyLoadPage({Key key, this.title}) : super(key: key);

  @override
  _MyLoadPageState createState() => _MyLoadPageState();
}



class _MyLoadPageState extends State<MyLoadPage>
    with AutomaticKeepAliveClientMixin {
  List<Widget> pages ;
  bool isMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(pages==null){
      pages = [NormalCalcPage(), RateParentPage()];
    }

  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by

        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),centerTitle: true,
        actions: <Widget>[
          Switch(
              value: isMore,
              onChanged: (value) {
                setState(() {
                  isMore = value;
                });
              })
        ],
      ),
      body: !isMore ? NormalCalcPage() : RateParentPage() ,
    );
  }
}
class NormalCalcPage extends StatefulWidget {
  NormalCalcPage({Key key}) : super(key: key);

  @override
  _NormalCalcPageState createState() => _NormalCalcPageState();
}

class _NormalCalcPageState extends State<NormalCalcPage> {


  final TextEditingController moneyController = new TextEditingController();
  final TextEditingController VolumeController = new TextEditingController();
  final TextEditingController TargetController = new TextEditingController();

  SpnnerControl spnnerTimeControl = new SpnnerControl();
  SpnnerControl spnnerRateCtrl = new SpnnerControl();

  bool isCanInputRateMomey = false;
  double rateMoney = 0;
  String displayDetail = "";
  ScrollController _scrollController;

  bool isNormal = false;

  @override
  void initState() {
    super.initState();
    _scrollController=ScrollController();
    TargetController.addListener(() {});
  }

  void checkAndCalc(TapUpDetails details) {
    Utils.closeKeybord(context);
    if (moneyController.text.isEmpty) {
      showTaost("금액을 입력해주세요");
      return null;
    }

    if (VolumeController.text.isEmpty) {
      showTaost("수량을 입력해주세요");
      return null;
    }

    if (TargetController.text.isEmpty) {
      showTaost("목표금액을 입력해주세요");
      return null;
    }

    double money = double.parse(moneyController.text);

    int volume = int.parse(VolumeController.text);

    double target = double.parse(TargetController.text);

    if (money == 0) {
      showTaost("금액이 0입니다.");
      return null;
    }

    if (target == 0) {
      showTaost('수량이 0입니다.');
      return null;
    }

    if (volume == 0) {
      showTaost("목표금액이 0입니다.");
      return null;
    }




    LoandInfo info = calc(money, target, volume);

    setState(() {
      rateMoney = info.interestTotal;
      displayDetail = info.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(10,10,10,0),
        height: MediaQuery.of(context).size.height * 0.66,
        color: Colors.black,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Palette.blueSkyLight,
        //       Palette.greenLandLight,
        //     ],
        //   ),
        // ),
        child : Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: TextField(
                    obscureText: false,

                    controller: moneyController,
                    keyboardType: TextInputType.number,
//                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly] ,
                    decoration: InputDecoration(
                      labelText: '매수단가',
                      hintText: '매수단가를 입력해주세요',
                      labelStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onTap: (){
                      _scrollController.animateTo(120, duration:
                      Duration(milliseconds: 500), curve: Curves.ease);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(top:15, left: 30,right: 30),
                  child: TextField(
                    obscureText: false,

                    controller: VolumeController,
                    keyboardType: TextInputType.number,


//                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly] ,
                    decoration: InputDecoration(
                      labelText: '매수수량',
                      hintText: '매수 수량을 입력해주세요',
                      labelStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onTap: (){
                      _scrollController.animateTo(120, duration:
                      Duration(milliseconds: 500), curve: Curves.ease);
                    },
                  ),
                ),
                SizedBox(width: 10),

                Padding(
                  padding: EdgeInsets.only(top:15, left: 30,right: 30),
                  child: TextField(
                    obscureText: false,

                    controller: TargetController,
                    keyboardType: TextInputType.number,

//                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly] ,
                    decoration: InputDecoration(
                      labelText: '목표금액',
                      hintText: '목표금액을 입력해주세요',
                      labelStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onTap: (){
                      _scrollController.animateTo(120, duration:
                      Duration(milliseconds: 500), curve: Curves.ease);
                    },
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(height: 50,),

                GestureDetector(
                  child: Container(
                    color: Colors.deepOrange,

                    child: SizedBox(
                      width: 200,
                      height: 56,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "계산하기",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                  ),
                  onTapUp: checkAndCalc,
                ),
                ButtonBar(
                  children: [
                    IconButton(onPressed: (){
                      moneyController.clear();
                      VolumeController.clear();
                      TargetController.clear();

                    }, icon: Icon(Icons.restart_alt))
                  ],
                )
              ],
            ),
          ),
        ),

      ),
      bottomSheet: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.rectangle,

        ),

        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Palette.blueSkyLight,
        //       Palette.greenLandLight,
        //     ],
        //   ),
        // ),
        child: Padding(
          padding: EdgeInsets.only( top: 20,left: 10,right: 10,bottom: 20),
          child: Card(
              shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child:  SizedBox(
                  width: 400,
                  height: 150,
                  child: Center(child: SingleChildScrollView(child: Text("$displayDetail"))))
          ),
        ),
      ),
    );

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

