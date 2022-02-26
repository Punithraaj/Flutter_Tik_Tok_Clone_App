import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tik_tok_clone_app/module/MainScreen.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class LoginScreenNotifier extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  late String email, password;
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FirebaseAuthService authService = FirebaseAuthService();

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  login(BuildContext context) async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in white before submiting');
    } else {
      form.save();
      loading = true;
      try {
        bool success = await authService.signIn(email, password);
        if (success) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
          print(" User Sign In Successfull: " + success.toString());
        } else {
          print(" User Sign In UnSuccessfull: " + success.toString());
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
        showInSnackBar('${authService.handleFirebaseAuthError(e.toString())}');
      }

      loading = false;
      notifyListeners();
    }
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
