import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Views/Dashboard.dart';
import 'package:flutter_application_1/Service/Auth_Service.dart';
import 'package:flutter_application_1/CommonWidgets/social_sign_in_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _MyHomePageState extends State<MyHomePage> {
AuthService auth = new AuthService();
void redirect() async {
  FirebaseUser currentUser = await _firebaseAuth.currentUser();
  Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new Dashboard(currentUser)));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Welcome to InviQ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 48.0),
            SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () => auth.signInWithGoogle().then((value) => redirect()),
          ),
          ],
        ),
      ),
    );
  }
}
