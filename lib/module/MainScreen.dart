import 'package:flutter/material.dart';
import 'package:tik_tok_clone_app/module/login/LoginScreen.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuthService auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
      child: Text('Main Screen'),
      onPressed: () {
        auth.signOut();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      },
    )));
  }
}
