import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tik_tok_clone_app/module/profile/UploadProfilePictureScreen.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

class RegistrationScreenNotifier extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? userName, email, password, confirmPassword;
  FocusNode userNameFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode confirmPassFN = FocusNode();
  FirebaseAuthService authService = FirebaseAuthService();

  register(BuildContext context) async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in white before submiting');
    } else {
      form.save();
      if (password == confirmPassword) {
        loading = true;
        notifyListeners();
        try {
          bool success =
              await authService.createUser(userName!, email!, password!);

          if (success) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => UploadProfilePictureScreen()));
            print(" User Sign Up Successfull: " + success.toString());
          } else {
            print(" User Sign Up UnSuccessfull: " + success.toString());
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          print(e);
          showInSnackBar(
              '${authService.handleFirebaseAuthError(e.toString())}');
        }

        loading = false;
        notifyListeners();
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

  setUserName(val) {
    userName = val;
    notifyListeners();
  }

  setConfirmPassword(val) {
    confirmPassword = val;
    notifyListeners();
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
