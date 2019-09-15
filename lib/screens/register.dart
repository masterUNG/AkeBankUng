import 'package:ake_bank_ung/screens/my_style.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();

  // Method
  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: Colors.pink,
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: Colors.pink),
        helperText: 'Type Your Name',
        helperStyle: TextStyle(color: Colors.pink),
        hintText: 'English Only',
      ),validator: (String value){
        if (value.isEmpty) {
          return 'Please Fill Your Name in Blank';
        }else {
          return null;
        }
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: Colors.green,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.green),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: Colors.green),
        hintText: 'you@email.com',
      ),validator: (String value){
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please keep Email Format';
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.purple,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: Colors.purple),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: Colors.purple),
        hintText: 'More 6 Charactor',
      ),
    );
  }

  Widget content() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, MyStyle().mainColor],
          begin: Alignment.topCenter,
        ),
      ),
      child: Form(key: formKey,
              child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(
        Icons.cloud_upload,
      ),
      onPressed: () {
        print('You Click Register');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text('Register'),
        actions: <Widget>[
          registerButton(),
        ],
      ),
      body: content(),
    );
  }
}
