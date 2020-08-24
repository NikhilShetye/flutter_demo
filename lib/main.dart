import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/HttpGetApp.dart';
import 'package:flutter_demo/LoadJsonApp.dart';
import 'package:flutter_demo/PokemonApp.dart';
import 'package:flutter_demo/WhatsApp.dart';
import 'package:flutter_demo/routes.dart';
import 'package:flutter_demo/viewsource.dart';

import 'FormValidationApp.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PhotosApp.dart';

void main() async {
  List currencies = await getCurrencies();
  // print(currencies);
  runApp(new CryptoApp(currencies));
}

class CryptoApp extends StatelessWidget {
  final List _currencies;

  CryptoApp(this._currencies);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null),
      home: new CryptoHomePage(_currencies),
      debugShowCheckedModeBanner: false,
      routes: {
        CryptoHomePage.routeCal: (context) => SourceViewer(),
        CryptoHomePage.routeJson: (context) => LoadJsonHomePage()
      },
    );
  }
}

Future<List> getCurrencies() async {
  String cryptourl =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=50&convert=USD";
  http.Response response = await http.get(
    //encoded url
      Uri.parse(cryptourl),
      //headers
      headers: {
        "accept": "application/json",
        "X-CMC_PRO_API_KEY": "ba728dad-db0e-4557-86fa-c2d24bbebe1f"
      });

  var convertojson = jsonDecode(response.body);
//  print(convertojson['data']);

  return convertojson['data'];
}

class CryptoHomePage extends StatefulWidget {
  static const routeCal = '/cal';
  static const routeJson = '/json';

  final List currencies;

  CryptoHomePage(this.currencies);

  @override
  State<StatefulWidget> createState() => CryptoHomePageState();
}

class CryptoHomePageState extends State<CryptoHomePage> {
  List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
          ],
          title: new Text("CryptoCoin App"),
          elevation:
          defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        body: new Container(
          child: _cryptoWidget(),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Nikhil Vinod Shetye"),
                accountEmail: Text("nikhilshetye26@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme
                      .of(context)
                      .platform == TargetPlatform.iOS
                      ? Colors.deepPurple
                      : Colors.white,
                  child: Text("P"),
                ),
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                    backgroundColor:
                    Theme
                        .of(context)
                        .platform == TargetPlatform.iOS
                        ? Colors.deepPurple
                        : Colors.white,
                    child: Text("P"),
                  ),
                ],
              ),
              ListTile(
                title: Text('Calculator'),
                trailing: new Icon(Icons.arrow_upward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, CryptoHomePage.routeCal);
                },
              ),
              ListTile(
                title: Text('HttpGet'),
                trailing: new Icon(Icons.arrow_downward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HttpGetApp()));
                },
              ),
              ListTile(
                title: Text('Load Json'),
                trailing: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, CryptoHomePage.routeJson);
                },
              ),
              ListTile(
                title: Text('Whats App'),
                trailing: Icon(Icons.message),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WhatsApp()));
                },
              ),
              ListTile(
                title: Text('Form Validation'),
                trailing: Icon(Icons.question_answer),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormValidationApp()));
                },
              ),
              ListTile(
                title: Text('Routes'),
                trailing: Icon(Icons.router),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RouteApp()));
                },
              ),
              ListTile(
                title: Text('Photos'),
                trailing: Icon(Icons.list),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhotosApp()));
                },
              ),
              ListTile(
                title: Text('Poke App'),
                trailing: Icon(Icons.verified_user),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PokeApp()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('Close'),
                trailing: Icon(Icons.close),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }

  Widget _cryptoWidget() {
    return new Container(
      child: new Column(
        children: [
          new Flexible(
              child: new ListView.builder(
                itemCount: widget.currencies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Map currency = widget.currencies[index];
                  final MaterialColor color = _colors[index % _colors.length];
                  return getListItemUi(currency, color);
                },
              )),
        ],
      ),
    );
  }

  ListTile getListItemUi(Map currency, MaterialColor color) {
    var quote = currency['quote'];
    var quoteUSD = quote['USD'];
    var price = quoteUSD['price'];
    var percentChange1h = quoteUSD['percent_change_1h'];
//    print(price);
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(
        currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubTitleText(price.toString(), percentChange1h.toString()),
      isThreeLine: true,
    );
  }

  Widget _getSubTitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD\n", style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour : $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }

    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }
}
