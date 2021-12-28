import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tik_tok_clone_app/module/MainScreen.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';
import 'package:tik_tok_clone_app/utils/validations.dart';

class LoginScreenNotifier extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  late String email, password;
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FirebaseAuthService auth = FirebaseAuthService();

  login(BuildContext context) async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      loading = true;
      notifyListeners();
      try {
        bool success = await auth.signIn(
          email,
          password,
        );
        print(success);
        if (success) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
        showInSnackBar('${auth.handleFirebaseAuthError(e.toString())}');
      }
      loading = false;
      notifyListeners();
    }
  }

  forgotPassword() async {
    loading = true;
    notifyListeners();
    FormState form = formKey.currentState!;
    print(Validations.validateEmail(email));
    if (Validations.validateEmail(email) != null) {
      showInSnackBar('Please input a valid email to reset your password.');
    } else {
      form.save();
      try {
        await auth.forgotPassword(email);
        showInSnackBar('Please check your email for instructions '
            'to reset your password');
      } catch (e) {
        showInSnackBar('${e.toString()}');
      }
    }
    loading = false;
    notifyListeners();
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
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
