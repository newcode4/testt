import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/common/dialog.dart';
import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/modal_class/GetxController.dart';
import 'package:testt/modal_class/notes.dart';
import 'package:testt/screens/Calculate.dart';

import 'cash_page.dart';

class DashPage extends StatefulWidget {
  DashPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  var f = NumberFormat('###,###,###,###');

  int money;
  String profit;
  String month_total = '0';


  @override
   initState()  {
    asyncMethod();
    money =  box.read('money');
    profit = box.read('profit');
    month_total = box.read('month_total');

    super.initState();
  }

  void asyncMethod() async {
    await DatabaseBuy().getTotal().then((value) =>
        value.forEach((element) async {
          String profit2 = await element.values.toString().substring(1, element.values
              .toString()
              .length - 1);


          box.write('profit',profit2);
          // print(profit2);
        }));

    await DatabaseBuy().MonthTotal().then((value) =>
        value.forEach((element) async {

          String month_total = await element.values.toString().substring(1, element.values
              .toString()
              .length - 1);
          box.write('month_total',month_total);
          print(month_total);
        }));
  }

  @override
  Widget build(BuildContext context) {
    final controller =  Get.put(Money());
    if(profit==null) profit ='0';
    controller.RateReturn(int.parse(profit), money);

    var _toDay = DateTime.now();
    var _toMonth = DateFormat('M').format(_toDay).toString();
    var f = NumberFormat('###,###,###,###');
    return Scaffold(
      body: Container(
        // color: Colors.white,
        child: Column(
            children: <Widget>[
        Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.4,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 3,
                spreadRadius: 3,
              )
            ],
            color: Colors.indigo[500],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              '마이페이지',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [
                      ButtonBar(
                      buttonPadding: EdgeInsets.zero,
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      RaisedButton(
                      onPressed: () {
                DepositDialog(context,profit);

                },
                  child: Text('입금'),
                  color: Colors.blue,
                ),

                Row(
                  children: [
                    GetBuilder<Money>(
                        builder: (_) {
                          return
                            InkWell(
                              child: Text('수익률 : ${_.total} %',
                                style: TextStyle(
                                     color: Colors.white,
                                  fontSize: 18
                                  ),
                                 ),
                              onTap: (){
                                controller.RateReturn(int.parse(profit), money);
                                print(profit);
                              },
                            );
                          }),
                  ],
                ),
            RaisedButton(
              onPressed: () {
                DepositDialog2(context,profit,money);
              },
              child: Text('출금'),
              color: Colors.red,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [

            GetBuilder<Money>(
                builder: (_) {
                  box.write('money', _.count3);
                  return Text(
                    '투자자금 : ${f.format(_.count3==null? 0: _.count3)}원',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                }),

          ],
        ),
        Row(
          children: [
            Text('  수익금 :  ${f.format(int.parse(profit))}원',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            SizedBox(
              width: 100,
            ),
          ],
        ),

        Row(
          children: [

            GetBuilder<Money>(
                builder: (_) {
                  int money_total = _.count3 + int.parse(profit);
                  total.write('total',money_total);
                  box.write('money', _.count3);
                  return Text(
                    '   합계 :     ${f.format( int.parse(profit)- _.count3 )}원',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80, right: 34, left: 34),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '$_toMonth월 수익',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  '${f.format(int.parse(month_total))}원'
                                      ,style: TextStyle(color: Colors.white),
                                )

                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '예상 세금',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  '${f.format(int.parse(month_total))}원'
                                  ,style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.calculate,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '계산기',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),onTap: (){
                                Navigator.push(
                                  context,MaterialPageRoute(builder: (context) => Calculate())
                                );
                            },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.account_balance,
                                      color: Colors.white),
                                  Text(
                                    '현금내역',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              onTap: (){
                                CashDiaLog(context);
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                Text(
                                  '즐겨찾기',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.indigo[500],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                                Text(
                                  '엑셀 출력',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

DepositDialog(context,profit) {
  TextEditingController price = TextEditingController();
  final controller = Get.put(Money());

  return showDialog(
    context: context,
    builder: (context) {
      var f = NumberFormat('###,###,###,###');
      return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.33,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '입금하기',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(children: [
                      Container(
                        width: 60,
                        child: Text("가격 : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: price,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "가격을 입력하세요",
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 14,
                    ),
                    ButtonBar(
                        buttonPadding: EdgeInsets.all(0),
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('취소'),
                          ),
                          CupertinoButton(
                              child: Text('확인'),
                              onPressed: () {
                                int money = int.parse(price.text);

                                controller.CountPlus(money);
                                controller.RateReturn(int.parse(profit), controller.count3);
                                _save('입금', 'volume', money);
                                Navigator.pop(context);
                              })
                        ]),
                  ]),
            ),
          ));
    },
  );
}

DepositDialog2(context,profit,money2) {
  TextEditingController price = TextEditingController();
  final controller = Get.put(Money());

  return showDialog(
    context: context,
    builder: (context) {
      var f = NumberFormat('###,###,###,###');
      return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.33,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '출금하기',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(children: [
                      Container(
                        width: 60,
                        child: Text("가격 : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: price,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "가격을 입력하세요",
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 14,
                    ),
                    ButtonBar(
                        buttonPadding: EdgeInsets.all(0),
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('취소'),
                          ),
                          CupertinoButton(
                              child: Text('확인'),
                              onPressed: () {
                                int money = int.parse(price.text);
                                controller.CountMinus(money);
                                controller.RateReturn(int.parse(profit),  controller.count3);
                                _save('출금', 'volume', money);
                                Navigator.pop(context);
                              })
                        ]),
                  ]),
            ),
          ));
    },
  );
}

void _save(String title, String volume, int total) async {
  DatabaseBuy helper = DatabaseBuy();
  Note note;
  note = Note(
      title, DateFormat('yyyy-MM-dd').format(DateTime.now()), volume, '',
      total.toString(), '','');


  if (note.id != null) {
    await helper.updateNote3(note);
  } else {
    await helper.insertMoney(note);
    await helper.updateNote3(note);
  }
}
