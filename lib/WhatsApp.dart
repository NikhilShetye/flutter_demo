import 'package:flutter/material.dart';

import 'models/chat_model.dart';

void main() => runApp(WhatsApp());

class WhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Whats App",
      theme: ThemeData(backgroundColor: Color(0xff0075e54)),
      home: WhatsAppHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WhatsAppHomePage extends StatefulWidget {
  @override
  _WhatsAppHomePageState createState() => _WhatsAppHomePageState();
}

class _WhatsAppHomePageState extends State<WhatsAppHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        backgroundColor: Color(0xff0075e54),
        elevation: 0.7,
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "CHATS"),
            Tab(text: "STATUS"),
            Tab(text: "CALLS"),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        CameraScreen(),
        ChatsScreen(),
        StatusScreen(),
        CallsSCreen()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("hello"),
        backgroundColor: Colors.green,
        child: new Icon(Icons.message),
      ),
    );
  }
}

class CallsSCreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Calls",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "camera",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) => Column(
              children: <Widget>[
                Divider(
                  height: 10.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(dummyData[index].avatarUrl),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        dummyData[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dummyData[index].time,
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ],
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      dummyData[index].message,
                      style: TextStyle(fontSize: 15.0, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ));
  }
}

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "Status",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
