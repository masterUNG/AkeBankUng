import 'package:ake_bank_ung/screens/home.dart';
import 'package:ake_bank_ung/screens/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String loginString = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Widget menuSignOut() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      subtitle: Text('Sign Out and Go To HomePage'),
      onTap: () {
        processSignOut();
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> processSignOut()async{
    await firebaseAuth.signOut().then((response){
      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      loginString = firebaseUser.displayName;
    });
  }

  Widget showLogin() {
    return Text(
      'Login by $loginString',
      style: TextStyle(
        fontSize: MyStyle().h2,
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Ake Bank Ung',
      style: TextStyle(
        color: MyStyle().textColor,
        fontSize: MyStyle().h1,
        fontFamily: 'PermanentMarker',
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 60.0,
      height: 60.0,
      child: Image.asset(
        'images/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, MyStyle().mainColor],
          radius: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          menuSignOut(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: myDrawer(),
    );
  }
}
