import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testt/common/SpnnerControl.dart';
import 'package:testt/modal_class/GetxController.dart';
import 'package:testt/modal_class/LoanInfo.dart';
import 'package:testt/utils/ToastUtils.dart';
import 'package:testt/utils/calc.dart';
import 'package:testt/utils/utils.dart';

class RateParentPage extends StatefulWidget {
  const RateParentPage({Key key}) : super(key: key);

  @override
  _RateParentPageState createState() => _RateParentPageState();
}

class _RateParentPageState extends State<RateParentPage> {


  bool isCanInputRateMomey = false;
  double rateMoney = 0;
  String displayDetail = "";

  bool isNormal = false;

  double money=0,money2=0,money3=0;
  int volume=0,volume2=0,volume3=0,volume4=0,volume5=0;
  double target,target2=0;
  TextEditingController moneyController;
  TextEditingController moneyController2;
  TextEditingController moneyController3;
  TextEditingController VolumeController;
  TextEditingController VolumeController2;
  TextEditingController VolumeController3;
  TextEditingController VolumeController4;
  TextEditingController VolumeController5;
  TextEditingController TargetController;
  TextEditingController TargetController2;



  final controller = Get.put(CalculateGetx());

  @override
  void initState() {
    super.initState();

    moneyController = new TextEditingController(text: '0');
    moneyController2 = new TextEditingController(text: '0');
    moneyController3 = new TextEditingController(text: '0');
   VolumeController = new TextEditingController(text: '0');
    VolumeController2 = new TextEditingController(text: '0');
    VolumeController3 = new TextEditingController(text: '0');
    VolumeController4 = new TextEditingController();
    VolumeController5 = new TextEditingController();
    TargetController = new TextEditingController();
    TargetController2 = new TextEditingController();
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

    money = double.parse(moneyController.text);
    money2 = double.parse(moneyController2.text);
    money3 = double.parse(moneyController3.text);

    volume = int.parse(VolumeController.text);
    volume2 = int.parse(VolumeController2.text);
    volume3 = int.parse(VolumeController3.text);

    target = double.parse(TargetController.text);
    target2 = double.parse(TargetController2.text);



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
    var f = NumberFormat('###,###,###,###.##');
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: MediaQuery.of(context).size.height * 0.84,
        color: Colors.black,

        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            elevation: 5,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text("매수1 ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: moneyController,
                            decoration: InputDecoration(

                                hintText: "매수가",
                                suffixText: '원',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value){

                              CalculateAVG(moneyController.text,moneyController2.text,moneyController3.text,
                              VolumeController.text,VolumeController2.text,VolumeController3.text);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: VolumeController,
                            decoration: InputDecoration(
                                hintText: "수량",
                                suffixText: '개',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value){
                              CalculateAVG(moneyController.text,moneyController2.text,moneyController3.text,
                                  VolumeController.text,VolumeController2.text,VolumeController3.text);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            moneyController.clear();
                            VolumeController.clear();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text("매수2 ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: moneyController2,
                            decoration: InputDecoration(
                                hintText: "매수가",
                                suffixText: '원',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value){
                              CalculateAVG(moneyController.text,moneyController2.text,moneyController3.text,
                                  VolumeController.text,VolumeController2.text,VolumeController3.text);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: VolumeController2,
                            decoration: InputDecoration(
                                hintText: "수량",
                                suffixText: '개',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value){
                              CalculateAVG(moneyController.text,moneyController2.text,moneyController3.text,
                                  VolumeController.text,VolumeController2.text,VolumeController3.text);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            moneyController2.clear();
                            VolumeController2.clear();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text("매수3 ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: moneyController3,
                            decoration: InputDecoration(
                                hintText: "매수가",
                                suffixText: '원',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value){
                              CalculateAVG(moneyController.text,moneyController2.text,moneyController3.text,
                                  VolumeController.text,VolumeController2.text,VolumeController3.text);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: VolumeController3,
                            decoration: InputDecoration(
                                hintText: "수량",
                                suffixText: '개',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value){
                              CalculateAVG(moneyController.text,moneyController2.text,moneyController3.text,
                                  VolumeController.text,VolumeController2.text,VolumeController3.text);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            moneyController3.clear();
                            VolumeController3.clear();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:5,left:10,right: 10),
                  child: Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(left:25,right: 5),
                      child: Container(
                        height: 40,
                        child: GetBuilder<CalculateGetx>(
                     init: CalculateGetx(),
                      builder: (_) {
                        return Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text("평단 ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Flexible(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text('${f.format(_.avgpurchase)}원',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),)
                              ),
                            ),
                            Flexible(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text('${f.format(_.avgvolume)}원',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),)
                              ),
                            ),
                            Flexible(
                              child: Container(
                                  child: Text('${f.format(_.avgtotal)}원',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),)
                              ),
                            ),

                          ],
                        );
                      }
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text("매도1 ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: TargetController,
                            decoration: InputDecoration(
                                hintText: "매도가",
                                suffixText: '원',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: VolumeController4,
                            decoration: InputDecoration(
                                hintText: "수량",
                                suffixText: '개',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            TargetController.clear();
                            VolumeController4.clear();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        child: Text("매도2 ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: TargetController2,
                            decoration: InputDecoration(
                                hintText: "매도가",
                                suffixText: '원',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: VolumeController5,
                            decoration: InputDecoration(
                                hintText: "수량",
                                suffixText: '개',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            TargetController2.clear();
                            VolumeController5.clear();
                          },
                          icon: Icon(Icons.clear))
                    ],
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 30,
                ),
                Card(
                  shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  color: Colors.white70,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 300,
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GetBuilder<CalculateGetx>(
                          init: CalculateGetx(),
                          builder: (_) {
                            return Column(
                              children: [
                                SizedBox(height: 8,),
                                Text('총매수금 : ${_.totalPurchase}',
                                  style: TextStyle(
                                      color: Colors.black
                                      , fontSize: 15
                                  ),),
                                SizedBox(height: 3,),
                                Text('수수료계 : ${_.totalFee}',
                                  style: TextStyle(
                                      color: Colors.red
                                      , fontSize: 15
                                  ),),
                                SizedBox(height: 3,),
                                Text('예상수익율 : ${_.extimatedRate}',
                                  style: TextStyle(
                                      color: Colors.black
                                      , fontSize: 15
                                  ),),
                                SizedBox(height: 3,),
                                Text('총매도금 : ${_.totalSales}',
                                  style: TextStyle(
                                      color: Colors.black
                                      , fontSize: 15
                                  ),),
                                SizedBox(height: 3,),
                                Text('제세금계 :',
                                  style: TextStyle(
                                      color: Colors.black
                                      , fontSize: 15
                                  ),),
                                SizedBox(height: 3,),
                                Text('예상손익 : ${_.extimatedMoney}',
                                  style: TextStyle(
                                      color: Colors.blue
                                      , fontSize: 15
                                  ),),
                              ],
                            );
                          }
                      )

                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        child: Center(child: CupertinoButton(child: Text('전체초기화'), onPressed: (){
          moneyController.clear();
          moneyController2.clear();
          moneyController3.clear();
          VolumeController.clear();
          VolumeController2.clear();
          VolumeController3.clear();
          VolumeController4.clear();
          VolumeController5.clear();
          TargetController.clear();
          TargetController2.clear();
          controller.AvgPurchase(0, 0);
        })),
      ),

    );
  }

  Widget CalculateAVG(m1,m2,m3,v1,v2,v3) {

    var a1 =0.0;
    var a2 =0.0;
    var a3 =0.0;
    var x1 =0.0;
    var x2 =0.0;
    var x3 =0.0;

     a1 = double.parse(m1==isNull? 0.0 : m1);
     a2 = double.parse(m2==isNull? 0.0 : m2);
     a3 = double.parse(m3==isNull? 0.0 : m3);

     // print(m3==isNull? 0.0 : m3);

     x1 = double.parse(v1==isNull? 0.0 : v1);
     x2 = double.parse(v2==isNull? 0.0 : v2);
     x3 = double.parse(v3==isNull? 0.0 : v3);

     print('$a1\n$a2\n$a3\n$v1\n$v2\n$v3');
     print(3);

     if()

    var avg_m = (a1+a2+a3)/3;
    var avg_v = (x1+x2+x3)/3;

    controller.AvgPurchase(avg_m, avg_v);




    // if(m1.isBlank && v1.isBlank) {m1=0.0; v1=0.0;}
    // else{
    //   var avg_m = (m1+m2+m3)/3;
    //   var avg_v = (v1+v2+v3)/3;
    //
    // controller.AvgPurchase(avg_m, avg_v);}
    // if(m2.isBlank && v2.isBlank) {m2=0.0; v2=0.0;}
    // else{
    //   var avg_m = (m1+m2+m3)/3;
    //   var avg_v = (v1+v2+v3)/3;
    //
    //   controller.AvgPurchase(avg_m, avg_v);}
    //
    // if(m3.isBlank && v3.isBlank) {m3=0.0; v3=0.0;}
    // else{
    //   var avg_m = (m1+m2+m3)/3;
    //   var avg_v = (v1+v2+v3)/3;
    //
    //   controller.AvgPurchase(avg_m, avg_v);}
    //
    // var avg_m = (m1+m2+m3)/3;
    // var avg_v = (v1+v2+v3)/3;



  }


}


