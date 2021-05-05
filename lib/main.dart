import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Views/Dashboard.dart';
import 'package:flutter_application_1/Service/Auth_Service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            new ElevatedButton(
              onPressed: () => auth.signInWithGoogle().then((value) => redirect()),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('images/google-logo.png'),
              Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.black87, fontSize: 15.0),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset('images/google-logo.png'),
              ),
            ],
          ),
            ),
          ],
        ),
      ),
    );
  }
}
