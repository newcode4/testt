import 'package:flutter/material.dart';
class DialogCollection {
  defaultDialog(BuildContext context) {
    return showDialog(
        context: context,
        //barrierDismissible: false, //on touch outside does not dismiss the dialog
        builder: (BuildContext context) {
          return WillPopScope(
            //WillPopScope stops dismissing dialog on outside touch and back press
            onWillPop: () {
              Navigator.of(context).pop();
              return null;
            },
            child: AlertDialog(
              title: Text(
                "Dialog Title",
                textAlign: TextAlign.center,
              ),
              titlePadding: const EdgeInsets.all(15.0),
              titleTextStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              content: Text("This is the description of the dialog."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}
class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialogs"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Button(
                  "DEFAULT DIALOG", DialogCollection().defaultDialog, context),
              //Button("DIALOG WITH ICON - 1", DialogCollection().customDialog_1(context)),
              /* Button("Widget", DialogCollection().defaultDialog(context)),
              Button("Widget", DialogCollection().defaultDialog(context)),
              Button("Widget", DialogCollection().defaultDialog(context)),
              Button("Widget", DialogCollection().defaultDialog(context)),*/
            ],
          ),
        ),
      ),
    );
  }
  Button(String text, Function callback, BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 230,
          child: RaisedButton(
            onPressed: () {
              callback(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.blueGrey,
            padding: EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 40.0, right: 40.0),
            textColor: Colors.white,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          height: 35,
        )
      ],
    );
  }
}
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DialogPage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}