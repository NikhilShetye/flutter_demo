import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/CalApp.dart';
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';


class SourceViewer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    final key = new GlobalKey<ScaffoldState>();
    String sourceTxt;


    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Source code",
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Scaffold(

        appBar: AppBar(
          leading: Icon(Icons.code,),
          title: Text("Source code",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20),),
        actions: <Widget>[
          InkWell(child: Icon(Icons.content_copy),
          onTap: () => {
          Clipboard.setData(new ClipboardData(text: sourceTxt)),

          },
        ) ,
          SizedBox(width: 20,),
          InkWell(child: Icon(Icons.launch),
          onTap: () => {
          Navigator.pop(context),
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => CalApp()))

          },

        ),
          SizedBox(width: 10,),

        ],

          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.cyan,
                      Colors.lightGreenAccent
                    ])
            ),
          ),
        ),
        body: Container(
          color: Colors.tealAccent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.cyan,Colors.lightGreenAccent]
              ),
              boxShadow:[
                BoxShadow(color: Colors.grey,
                blurRadius: 10)
              ]

            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: FutureBuilder(
                    future: loadAsset(context),
                    builder: (context,snapshot){
                     sourceTxt =snapshot.data.toString();
                      return  GestureDetector(
                        child: Text(
                          '$sourceTxt',style: TextStyle(color: Colors.black,
                           ),),

                      );
                    },
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }



  Future<String> loadAsset(BuildContext context)  async {
    String fileText = await rootBundle.loadString('load_json/CalApp.txt');
    print(fileText);
    return fileText;
  }

  Future<List<String>> getFileLines() async {
    ByteData data = await rootBundle.load('load_json/CalApp.txt');
    String directory = (await getApplicationDocumentsDirectory()).path;
    File file = await writeToFile(data, '$directory/source.txt');
    return await file.readAsLines();
  }

  Future<File> writeToFile(ByteData data, String path) {
    ByteBuffer buffer = data.buffer;
    return File(path).writeAsBytes(buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    ));
  }
}
