import 'package:ake_bank_ung/screens/my_style.dart';
import 'package:ake_bank_ung/screens/register.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  double widthLogo = 100.0;

  // Method
  Widget signUpButton() {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyStyle().mainColor),
      child: Text(
        'Sign Up',
        style: TextStyle(color: MyStyle().mainColor),
      ),
      onPressed: () {
        print('You Click Sign Up');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget singInButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: MyStyle().mainColor,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget showButton() {
    return Container(
      // color: Colors.grey,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          singInButton(),
          SizedBox(
            width: 4.0,
          ),
          signUpButton(),
        ],
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: widthLogo,
      height: widthLogo,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ake Bank Ung',
      style: TextStyle(
        fontSize: MyStyle().h1,
        color: MyStyle().textColor,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'PermanentMarker',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/wallpaper.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Color.fromRGBO(255, 255, 255, 0.7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showLogo(),
                  showAppName(),
                  showButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
