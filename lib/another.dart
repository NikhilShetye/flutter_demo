import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",
        theme: ThemeData(primarySwatch: Colors.purple),
        debugShowCheckedModeBanner: false,
        
        home: CupertinoTabScaffold
        (
          tabBuilder: (context, i) => Center(
            child: i==0 ? Text('Phone',
            style: TextStyle(
              decoration: TextDecoration.none
            ),): Text('Chats',
            style: TextStyle(decoration: TextDecoration.none),)),
          
          tabBar: CupertinoTabBar(items:[ BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone),title: Text("Phone")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.conversation_bubble),
            title: Text("Chats"))
            ]
            
            ),
            ),
        );
  }
}

class MyIosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScffold();
  }
}

class CupertinoPageScffold extends StatelessWidget {
  const CupertinoPageScffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text('hello cupertino ios',
        style: TextStyle(fontSize: 20.0,
      )),
      ),
      navigationBar: CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.back),
        middle: Text("Cupertino "),
        trailing: Icon(CupertinoIcons.search),
      ),
    );
  }
}
