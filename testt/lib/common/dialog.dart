import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/library/do_progress_bar.dart';
import 'package:testt/modal_class/GetxController.dart';
import 'package:testt/modal_class/notes.dart';
import 'package:testt/screens/note_detail.dart';

showDialogFunc(context, title) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 180,
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
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: ButtonBar(
                      buttonHeight: 40,
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            // showDialogFunc2(context,title);
                            navigateToDetail2(
                                Note(title, '', '', '', '',''), '생성하기', context);
                          },
                          child: Text('매수하기'),
                          color: Colors.blue,
                        ),
                        RaisedButton(
                          onPressed: () {
                            // showDialogFunc3(context, title);
                            print('$title 매도하기');
                          },
                          child: Text('매도하기'),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

showDialogFunc2(context, title) {
  int color;
  bool isEdited = false;
  Note note;

  TextEditingController price = TextEditingController();
  TextEditingController volume = TextEditingController();
  DatabaseBuy databaseHelper = DatabaseBuy();

  Future<int> insertNote() async {
    volume.text = note.title;
    price.text = note.description;
    note.date = DateFormat.yMMMd().format(DateTime.now());

    if (note.id != null) {
      await databaseHelper.updateNote(note);
    } else {
      await databaseHelper.insertNote(note);
    }
  }

  void updateTitle() {
    isEdited = true;
    note.title = price.text;
  }

  void updateDescription() {
    isEdited = true;
    note.description = volume.text;
  }

  var value3;
  var value4;
  var result = 0;
  var cnt = 0;

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
              height: 300,
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
                      title,
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
                            onChanged: (value) {
                              updateTitle();
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return '가격을 입력하세요';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        width: 60,
                        child: Text("수량 : ",
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
                            controller: volume,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "수량을 입력하세요",
                                hintStyle: TextStyle(color: Colors.grey[300])),
                            cursorColor: Colors.blue,
                            onChanged: (value) {
                              updateDescription();
                            },
                          ),
                        ),
                      ),
                    ]),
                    ButtonBar(
                        buttonPadding: EdgeInsets.all(0),
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              var value3 = int.parse(price.text);
                              var value4 = int.parse(volume.text);
                              result = value3 * value4;
                              print(result);
                            },
                            child: Text('확인'),
                          ),
                          CupertinoButton(
                              child: Text('저장'),
                              onPressed: () {
                                final DateTime now = DateTime.now();
                                final String btime =
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                                final String bname = title.toString();
                                final String bprice = price.text;
                                final String bvolume = volume.text;
                                final String btotal = result.toString();

                                // final ItemBuyModel product = ItemBuyModel(
                                //     title: bname,
                                //     buyTime: btime,
                                //     buyPrice: bprice,
                                //     buyVolume: bvolume,
                                //     buyTotal: btotal);
                                // insertData(product.toMap());
                                insertNote();
                                Navigator.pop(context);
                              })
                        ]),
                    SizedBox(
                      height: 18,
                    ),
                    Row(children: [
                      Container(
                        width: 60,
                        child: Text("합계 : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Text(
                              "${f.format(result)}원",
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ]),
                  ]),
            ),
          ));
    },
  );
}

void moveToLastScreen(context) {
  Navigator.pop(context, true);
}

void navigateToDetail2(Note note, String title, BuildContext context) async {
  bool result =
  await Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NoteDetail(note, title);
  }));
}

LogDiaLog(context,int id, String title, String Volume, int datatotal,String description) {
  TextEditingController price = TextEditingController();
  final controller = Get.put(BuilderController());
  controller.resultdata(double.parse(Volume), 0);


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
                  .height * 0.68,
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
                      title,
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
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return controller.resultdata(
                                    double.parse(Volume), 0);
                              }
                              return controller.resultdata(
                                  double.parse(Volume), int.parse(price.text));
                            },
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("수량 :  $Volume개 보유 중입니다.",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        child: GetBuilder<BuilderController>(
                            init: BuilderController(),
                            builder: (_) {
                              return GestureDetector(
                                child: DoProgressBar(
                                  title: " ",
                                  width: 150,
                                  percentage: _.count,
                                  firstlimit: _.count * 0.3,
                                  secondlimit: _.count * 0.7,
                                ),
                              );
                            })),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      child: GetBuilder<BuilderController>(
                          init: BuilderController(),
                          builder: (_) {
                            return Text("합계 : ${f.format(_.total)}원",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold));
                          }),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    ButtonBar(
                        buttonPadding: EdgeInsets.only(bottom: 2, top: 4),
                        alignment: MainAxisAlignment.center,
                        buttonHeight: 30,
                        buttonMinWidth: 30,
                        children: [
                          RaisedButton(
                              child: Text("-10"),
                              onPressed: () {
                                controller.decrease2();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
                          RaisedButton(
                              child: Text("-1"),
                              onPressed: () {
                                controller.decrease();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
                          RaisedButton(
                              child: Text("+1"),
                              onPressed: () {
                                controller.decrease();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
                          RaisedButton(
                              child: Text("+10"),
                              onPressed: () {
                                controller.increment2();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
                        ]),
                    ButtonBar(
                        buttonPadding: EdgeInsets.only(bottom: 0, top: 0),
                        buttonMinWidth: 50,
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                              child: Text("10%"),
                              onPressed: () {
                                controller.ten();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
                          RaisedButton(
                              child: Text("50%"),
                              onPressed: () {
                                controller.fifty();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
                          RaisedButton(
                              child: Text("100%"),
                              onPressed: () {
                                controller.one_hundred();
                                controller.resultdata(
                                    controller.count, int.parse(price.text));
                              }),
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
                              child: Text('매도'),
                              onPressed: () {
                                if(int.parse(Volume) == controller.count) {
                                  DatabaseBuy databaseHelper = DatabaseBuy();
                                  databaseHelper.deleteNote(id);
                                }
                                if(controller.total ==0){


                                }else{
                                  int total = int.parse(controller.total
                                      .toStringAsFixed(0));

                                  int result = total - datatotal;
                                  _save(title, controller.total.toString(), result);
                                  Navigator.pop(context);
                                }



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
      total.toString(), '');


  if (note.id != null) {
    await helper.updateNote2(note);
  } else {
    await helper.insertNote2(note);
    await helper.updateNote2(note);
  }
}

