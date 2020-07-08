import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/devfest.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  Devfest.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google DevFest",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(appBar: AppBar(title: Text('Google DevFest'),
      ),
      body: Container(child: Text('Hi'),),),
    );
  }
}
