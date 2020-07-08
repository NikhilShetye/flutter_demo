import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(LoadJsonApp());

class LoadJsonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Load Json",
      theme: ThemeData(
        primarySwatch: Colors.cyan
      ),
      home: LoadJsonHomePage(),
            debugShowCheckedModeBanner: false,

    );
  }
}

class LoadJsonHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoadJsonHomePageState();
}

class LoadJsonHomePageState extends State<LoadJsonHomePage> {
  List data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Load json app"),
      ),
      body: new Container(
        child: new Center(
          child: new FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('load_json/person.json'),
            builder: (context, snapshot) {
              final myData = List.from(jsonDecode(snapshot.data.toString()));
              return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Text("Name: " + myData[index]['name']),
                            new Padding(
                                padding: new EdgeInsets.only(bottom: 8)),
                            new Text("Gender: " + myData[index]['gender']),
                            new Padding(
                                padding: new EdgeInsets.only(bottom: 8)),
                            new Text(
                                "Hair Color: " + myData[index]['hair_color']),
                            new Padding(
                                padding: new EdgeInsets.only(bottom: 8)),
                            new Text("Age: " + myData[index]['age']),
                            new Padding(
                                padding: new EdgeInsets.only(bottom: 8)),
                            new Text("Height: " + myData[index]['height']),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: myData.length == null ? 0 : myData.length);
            },
          ),
        ),
      ),
    );
  }
}
