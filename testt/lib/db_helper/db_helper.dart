import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:testt/common/Constants.dart';
import 'package:testt/modal_class/notes.dart';

class DatabaseBuy {
  static DatabaseBuy _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String noteTable = 'buy_table';
  String noteTable2 = 'sell_table';
  String noteTable3 = 'money_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPrice = 'price';
  String colVolume = 'volume';
  String colTotal = 'total';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colColor = 'color';
  String colMoney = 'money';
  String colDate = 'date';
  String colMonthTotal = 'monthtotal';

  DatabaseBuy._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseBuy() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseBuy
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    String buyTable =
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,'
        '$colPrice TEXT, $colVolume TEXT, $colTotal Text, $colDescription TEXT, $colPriority INTEGER, $colMonthTotal INTEGER,$colDate TEXT);';

    String sellTable =
        'CREATE TABLE $noteTable2($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,'
        '$colPrice TEXT, $colVolume TEXT, $colTotal Text, $colDescription TEXT, $colPriority INTEGER, $colMonthTotal INTEGER,$colDate TEXT);';

    String moneyTable =
        'create table $noteTable3($colId integer primary key autoincrement, $colTitle Text,'
        '$colMoney Test);';

    await db.execute(buyTable);
    await db.execute(sellTable);
    await db.execute(moneyTable);

    newVersion = 1;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colDate DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList2() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable2, orderBy: '$colId DESC');
    return result;
  }


  Future<List<Map<String, dynamic>>> getMonth() async {
    Database db = await this.database;
    var re = await db.rawQuery(
        'Select  sum($colTotal), $colDate  FROM $noteTable2 GROUP BY strftime("%m")  ');
    return re;
  }

  Future<List<Map<String, dynamic>>> getTotal() async {
    Database db = await this.database;
    var re = await db
        .rawQuery('Select  sum($colTotal) as total  FROM $noteTable2  ');
    return re;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> insertNote2(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable2, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> updateNote2(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable2, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  Future<int> deleteNote2(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $noteTable2 WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount2() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $noteTable2');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getAll() async {
    var database = await this.database;
    List<Map> rawList = await database.rawQuery('SELECT * FROM $noteTable2');
    return List.generate(
        rawList.length,
            (index) =>
            Note(rawList[index]['title'], rawList[index]['date'], '', '',
                rawList[index]['total'], ''));
  }

  // Future<Map<DateTime, List<String>>> getStatus() async {
  //   var database = await this.database;
  //   List<Map> rawList = await database.rawQuery('SELECT * FROM $noteTable2');
  //   return Map.fromIterable(rawList,
  //       key: (value) => DateTime.fromMillisecondsSinceEpoch(value['date']),
  //       value: (value) => List<String>.from(jsonDecode(value['total'])));
  // }


  Future<List<Note2>> dogs() async {
    // 데이터베이스 reference를 얻습니다.
    final Database db = await database;

    // 모든 Dog를 얻기 위해 테이블에 질의합니다.
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT (*) from $noteTable2');

    // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
    return List.generate(x.length, (i) {
      return Note2(
        title: x[i]['title'],
        total: x[i]['total'],
        date: x[i]['date'],
      );
    });
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMap(noteMapList[i]));
    }

    return noteList;
  }

  Future<List<Note>> getNoteList2() async {
    var noteMapList = await getNoteMapList2(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMap(noteMapList[i]));
    }

    return noteList;
  }

}