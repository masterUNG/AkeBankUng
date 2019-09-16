import 'package:ake_bank_ung/screens/my_service.dart';
import 'package:ake_bank_ung/screens/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String email = '', password = '';

  // Method
  Widget backButton() {
    return IconButton(
      icon: Icon(Icons.navigate_before),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAppName() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListTile(
        leading: Container(
          width: 48.0,
          height: 48.0,
          child: Image.asset('images/logo.png'),
        ),
        title: Text(
          'Ake Bank Ung',
          style: TextStyle(
            fontSize: MyStyle().h1,
            color: MyStyle().textColor,
          ),
        ),
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Email :',
        ),
        onSaved: (String value) {
          email = value.trim();
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Password :',
        ),
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Widget content() {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showAppName(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String errorMessage = response.message;
      print('errorMessage = $errorMessage');
      mySnackBar(errorMessage);
    });
  }

  void mySnackBar(String message){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, MyStyle().mainColor],
              radius: 1.0,
            ),
          ),
          child: Stack(
            children: <Widget>[
              backButton(),
              content(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          formKey.currentState.save();
          checkLogin();
        },
      ),
    );
  }
}
