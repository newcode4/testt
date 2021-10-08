import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:testt/db_helper/db_helper.dart';
import 'package:testt/modal_class/GetxController.dart';
import 'package:testt/modal_class/notes.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;


  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  DatabaseBuy helper = DatabaseBuy();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdited = false;

  NoteDetailState(this.note, this.appBarTitle);

  var value3;
  var value4;
  var result = 0;

  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CounterController());
    controller.result=0;

    titleController.text = note.title;
    descriptionController.text = note.description;
    priceController.text = note.price;
    volumeController.text = note.volume;

    var f = NumberFormat('###,###,###,###');
    return WillPopScope(
        onWillPop: () async {
          isEdited ? showDiscardDialog(context) : moveToLastScreen();
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              appBarTitle,
              style: Theme.of(context).textTheme.headline5,
            ),centerTitle: true,

            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  isEdited ? showDiscardDialog(context) : moveToLastScreen();
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () {
                  titleController.text.length == 0 || controller.result == 0
                      ? showEmptyTitleDialog(context)
                      : _save();
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.black),
                onPressed: () {
                  showDeleteDialog(context);
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 15,),
                Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: titleController,

                    style: Theme.of(context).textTheme.bodyText2,
                    onChanged: (value) {
                      // value3 = value ;
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: '종목명',
                      hintText: '종목명을 입력해주세요',
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:15, left: 30,right: 30),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                    controller: priceController,
                    style: Theme.of(context).textTheme.bodyText2,
                    onChanged: (value) {
                      updatePrice();
                    },
                    decoration: InputDecoration(
                      labelText: '매수가',
                      hintText: '매수가를 입력해주세요',
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:15, left: 30,right: 30),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
                    controller: volumeController,
                    style: Theme.of(context).textTheme.bodyText2,
                    onChanged: (value) {

                      updateVolume();
                    },
                    decoration: InputDecoration(
                      labelText: '수량',
                      hintText: '수량을 입력해주세요',
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
                  ),
                ),
                SizedBox(height: 7,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: GetBuilder<CounterController>(
                          init: CounterController(),
                          builder: (_) {
                            return Text(_.result == null ?  '' : "합계 : ${f.format(_.result)}원",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold));
                          }),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        controller.calculate(volumeController.text,priceController.text );
                        updateTotal();

                      },
                      child: Text('확인하기'),
                    ),

                  ],
                ),

                SizedBox(height: 7,),

                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      controller: descriptionController,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (value) {
                        updateDescription();
                      },
                      decoration: InputDecoration(
                        labelText: '부가설명',
                        hintText: '부가설명을 적어주세요',
                        labelStyle: TextStyle(color: Colors.black26),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.black26),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Colors.black26),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "수정",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
          ),
          content: Text("수정을 안하시겠습니까?",
              style: Theme.of(context).textTheme.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text("아니요",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("네",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                moveToLastScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void showEmptyTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "종목명/확인하기",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
          ),
          content: Text('종목명과 확인하기는 필수로 입력을 해야합니다!',
              style: Theme.of(context).textTheme.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text("확인",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "삭제",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
          ),
          content: Text("이 종목을 정말로 삭제하시겠습니까?",
              style: Theme.of(context).textTheme.bodyText1),
          actions: <Widget>[
            TextButton(
              child: Text("아니요",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("네",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                _delete();
              },
            ),
          ],
        );
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    isEdited = true;
    note.title = titleController.text;
  }

  void updatePrice() {
    isEdited = true;
    note.price = priceController.text;
  }

  void updateVolume() {
    isEdited = true;
    note.volume = volumeController.text;
  }

  void updateTotal() {
    isEdited = true;
    final controller = Get.put(CounterController());
    note.total = controller.result.toString();
    print(note.total);

  }

  void updateDescription() {
    isEdited = true;
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    note.date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (note.id != null) {
      await helper.updateNote(note);
    } else {
      await helper.insertNote(note);
    }
  }

  void _delete() async {
    await helper.deleteNote(note.id);
    moveToLastScreen();
  }
}
