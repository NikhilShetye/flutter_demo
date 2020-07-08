import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(CalApp());

class CalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.red),
      home: CalHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalHomePage extends StatefulWidget {
  State createState() => CalHomePageState();
}

class CalHomePageState extends State<CalHomePage> {
  var num1 = 0, num2 = 0, result = 0;
  doAdd() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      result = num1 + num2;
    });
  }

  doSub() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      result = num1 - num2;
    });
  }

  doMul() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      result = num1 * num2;
    });
  }

  doDiv() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      result = num1 ~/ num2;
    });
  }

  void doClear() {
    setState(() {
      t1.text = "0";
      t2.text = "0";
      result = 0;
    });
  }

  final TextEditingController t1 = new TextEditingController(text: "0");
  final TextEditingController t2 = new TextEditingController(text: "0");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(40),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Output : $result ",
              style: new TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            new TextField(
              keyboardType: TextInputType.number,
              controller: t1,
            ),
            new TextField(
              keyboardType: TextInputType.number,
              controller: t2,
            ),
            new Padding(padding: new EdgeInsets.only(top: 20)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("+"),
                  color: Colors.greenAccent,
                  onPressed: doAdd,
                ),
                new MaterialButton(
                  child: new Text("-"),
                  color: Colors.greenAccent,
                  onPressed: doSub,
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("*"),
                  color: Colors.greenAccent,
                  onPressed: doMul,
                ),
                new MaterialButton(
                  child: new Text("/"),
                  color: Colors.greenAccent,
                  onPressed: doDiv,
                ),
              ],
            ),
            new Padding(padding: new EdgeInsets.only(top: 20)),
            new MaterialButton(
              child: new Text("Clear"),
              color: Colors.greenAccent,
              onPressed: doClear,
            ),
          ],
        ),
      ),
    );
  }
}
