import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(HttpGetApp());

class HttpGetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Load Http Get",
      theme: ThemeData(primarySwatch: Colors.lime),
      home: HttpGetHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HttpGetHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HttpGetHomePageState();
}

class HttpGetHomePageState extends State<HttpGetHomePage> {
  String url = "https://swapi.dev/api/people/";
  List data;

  @override
  initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    var response = await http.get(
        //encoded url
        Uri.parse(url),
        //headers
        headers: {"accept": "application/json"});

    print(response.body);

    setState(() {
      var convertToJsonData = jsonDecode(response.body);
      data = convertToJsonData['results'];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Retreive json via HTTP Get"),
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    elevation: 0.0,
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: new EdgeInsets.all(20),
                    ),
                  )
                ],
              ),
            ));
          },
          itemCount: data == null ? 0 : data.length,
        ));
  }
}
