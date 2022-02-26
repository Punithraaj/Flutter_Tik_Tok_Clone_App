import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class MainScreenNotifier extends ChangeNotifier {
  FirebaseAuthService authService = FirebaseAuthService();

  signOut(BuildContext context) async {
    await authService.signOut();
    notifyListeners();
    showInSnackBar("Sign-out");
  }

  void showInSnackBar(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }
}
