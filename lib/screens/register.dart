import 'package:ake_bank_ung/screens/my_service.dart';
import 'package:ake_bank_ung/screens/my_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name in Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value;
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
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please keep Email Format';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
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
      validator: (String value) {
        if (value.length < 6) {
          return 'Password More 6 Charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
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
      child: Form(
        key: formKey,
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
          print(
              'name = $nameString, email = $emailString, password = $passwordString');
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {
    
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      // print('Error = ${response.toString()}');
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  Future<void> setupDisplayName()async{

    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nameString;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);



  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.red),),
          content: Text(message),
          actions: <Widget>[okButton()],
        );
      },
    );
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
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
