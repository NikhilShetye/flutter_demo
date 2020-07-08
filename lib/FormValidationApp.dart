import 'package:flutter/material.dart';

void main() => {runApp(FormValidationApp())};

class FormValidationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: FormValidHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormValidHomePage extends StatefulWidget {
  @override
  _FormValidHomePageState createState() => _FormValidHomePageState();
}

class _FormValidHomePageState extends State<FormValidHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      perFormLogin();
    }
  }

  void perFormLogin() {
    final _scackBar =
        SnackBar(content: Text("Email $_email, Password $_password"));
    _scaffoldKey.currentState.showSnackBar(_scackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Text Form Page"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) =>
                        !value.contains("@") ? 'Invalid Email' : null,
                    onSaved: (newValue) => _email = newValue,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.length < 6 ? 'Paswword  too short' : null,
                    onSaved: (newValue) => _password = newValue,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  RaisedButton(child: Text("Login"), onPressed: _submit)
                ],
              )),
        ));
  }
}
