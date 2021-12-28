import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class RegistrationScreenNotifier extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? username, email, password, cPassword;
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode countryFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode cPassFN = FocusNode();
  FirebaseAuthService auth = FirebaseAuthService();

  register(BuildContext context) async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      if (password == cPassword) {
        loading = true;
        notifyListeners();
        try {
          bool success = await auth.createUser(
            username!,
            email!,
            password!,
          );
          print(success);
          if (success) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => Scaffold()));
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          print(e);
          showInSnackBar('${auth.handleFirebaseAuthError(e.toString())}');
        }
        loading = false;
        notifyListeners();
      } else {
        showInSnackBar('The passwords does not match');
      }
    }
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  setUsername(val) {
    username = val;
    notifyListeners();
  }

  setConfirmPass(val) {
    cPassword = val;
    notifyListeners();
  }

  void showInSnackBar(String value) {
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }
}
