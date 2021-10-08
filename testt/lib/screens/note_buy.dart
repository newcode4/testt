import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/common/dialog.dart';
import 'package:testt/db_helper/db_helper.dart';

import 'package:testt/modal_class/GetxController.dart';
import 'package:testt/modal_class/notes.dart';
import 'package:testt/screens/search_note.dart';

import 'note_detail.dart';

class NoteBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteBuyState();
  }
}

class NoteBuyState extends State<NoteBuy> {
  DatabaseBuy databaseHelper = DatabaseBuy();
  List<Note> noteList, noteList2;
  int count,
      count2 = 0;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = [];
      updateListView();
    }

    if (noteList2 == null) {
      noteList2 = [];
      updateListView2();
    }

    Widget myAppBar() {
      return AppBar(
        title: Text('매매일지', style: Theme
            .of(context)
            .textTheme
            .headline5),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: noteList.length == 0
            ? Container()
            : IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () async {
             Note result = await showSearch(
                context: context, delegate: NotesSearch(notes: noteList2));
            if (result != null) {
              navigateToDetail(result, '수정하기');
            }
          },
        ),
        actions: <Widget>[
          noteList.length == 0
              ? Container()
              : IconButton(
            icon: Icon(
              axisCount == 2 ? Icons.list : Icons.grid_on,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                axisCount = axisCount == 2 ? 4 : 2;
              });
            },
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.black,
          tabs: <Widget>[
            Tab(
              child: Text('진행종목', style: TextStyle(color: Colors.black)),
            ),
            Tab(
              child: Text('완료종목', style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: myAppBar(),
        body: noteList.length == 0
            ? Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('종목을 추가해주세요',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2),
            ),
          ),
        )
            : TabBarView(children: <Widget>[
          getNotesList(),
          getNotesList2(),
        ]),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToDetail(Note('', '', '', '', '',''), '생성하기');
          },
          tooltip: 'Add Note',
          shape: CircleBorder(
              side: BorderSide(color: Colors.black, width: 2.0)),
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget getNotesList() {
    var f = NumberFormat('###,###,###,###');
    final controller = Get.put(BuilderController());
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) =>
          GestureDetector(
            onTap: () {
              navigateToDetail(this.noteList[index], '수정하기');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              this.noteList[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                print(this.noteList[index].title);
                                print(this.noteList[index].volume);
                                print(this.noteList[index].total);

                                LogDiaLog(context,this.noteList[index].id, this.noteList[index].title,
                                  this.noteList[index].volume,
                                  int.parse(this.noteList[index].total),);
                                controller.movedata(
                                    this.noteList[index].volume);
                              },
                              child: const Text('매도하기'),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              this.noteList[index].total == null //수정 다큐멘터리에서
                                  ? ''
                                  : '매수가 : ${f.format(
                                  int.parse(this.noteList[index].price))}원\n'
                                  '평가금액 : ${f.format(
                                  int.parse(this.noteList[index].total))}원',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,),
                          ),

                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(this.noteList[index].date,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle2),
                        ])
                  ],
                ),
              ),
            ),
          ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget getNotesList2() {
    updateListView2();
    bool chage =true;
    var f = NumberFormat('###,###,###,###');
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count2,
      itemBuilder: (BuildContext context, int index) {
        if(double.parse(this.noteList2[index].total)>0) chage = true;
        if(double.parse(this.noteList2[index].total)<0) chage = false;
        return GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              this.noteList2[index].title,
                              style: TextStyle(
                                color:  chage? Colors.redAccent: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                FinishDiaLog(context, this.noteList2[index].title, this.noteList2[index].total,
                                this.noteList2[index].date);
                                // DatabaseBuy().getMonth().then((value) => value.forEach((element){
                                //   print(element.values);
                                // }));
                                // print('dd');
                              },
                              child: const Text('내역'),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '거래차익 : ${f.format(
                                  int.parse(this.noteList2[index].total))}원',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,),
                          ),

                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(this.noteList2[index].date,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle2),
                        ])
                  ],
                ),
              ),
            ),
          );
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, '삭제되었습니다.');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return NoteDetail(note, title);
        }));


    if (result == true) {
      updateListView();
    }
  }


  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void updateListView2() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList2();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList2 = noteList;
          this.count2 = noteList.length;
        });
      });
    });
  }

}

FinishDiaLog(context, String title, String total,String date) {



  // final String buyDatetime = "buyDatetime";



  var f = NumberFormat('###,###,###,###');
  var test = [];
  DatabaseBuy().getMonth().then((value) => value.forEach((element) {
    print(element.values);
  }));
  List<Note> elements = [

      Note(title, date, '', '', total, '')

  ];
  return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text(title),
              centerTitle: true,
            ),
            body: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  GroupedListView<Note, String>(
                    shrinkWrap: true,
                    elements: elements,
                    // 리스트에 사용할 데이터 리스트
                    groupBy: (element) => element.date.split(' ')[0],
                    // 데이터 리스트 중 그룹을 지정할 항목
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    //groupBy 항목을 비교할 비교기
                    itemComparator: (item1, item2) => item1.date
                        .split(' ')[0]
                        .compareTo(item2.date.split(' ')[0]),
                    // 그룹안의 데이터 비교기
                    order: GroupedListOrder.DESC,
                    //정렬(오름차순)
                    useStickyGroupSeparators: false,
                    //가장 위에 그룹 이름을 고정시킬 것인지
                    groupSeparatorBuilder: (String value) => Padding(
                      //그룹 타이틀 모양
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    itemBuilder: (c, element) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            color: Colors.white,
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  title: Text(
                                    title,
                                    style: TextStyle(
                                      // color: chage
                                      // ? Colors.redAccent
                                      //     : Colors.blue,
                                      fontSize: 16.5,
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "\n거래차익 : $total원",
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ))),
                      );
                    },
                  ),
                ]));
      });

}