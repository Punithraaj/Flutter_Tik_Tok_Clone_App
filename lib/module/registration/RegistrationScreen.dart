import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_clone_app/module/login/LoginScreen.dart';
import 'package:tik_tok_clone_app/module/registration/RegistrationScreenNotifier.dart';
import 'package:tik_tok_clone_app/utils/validations.dart';
import 'package:tik_tok_clone_app/utils/widgets/AlreadyHaveAnAccountCheck.dart';
import 'package:tik_tok_clone_app/utils/widgets/OrDivider.dart';
import 'package:tik_tok_clone_app/utils/widgets/SocialIcon.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    RegistrationScreenNotifier viewModel =
        Provider.of<RegistrationScreenNotifier>(context);
    final Size deviceSize = MediaQuery.of(context).size;
    return ModalProgressHUD(
        inAsyncCall: viewModel.loading,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          key: viewModel.scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                HexColor("CB2B93"),
                HexColor("9546C4"),
                HexColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/images/musical-note.png",
                      fit: BoxFit.fitWidth,
                      height: 150,
                      color: Colors.white,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: viewModel.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            key: new Key('userName'),
                            enabled: !viewModel.loading,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_rounded,
                                color: Colors.white70,
                              ),
                              labelText: 'User Name',
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                            autocorrect: true,
                            cursorColor: Colors.white,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            keyboardType: TextInputType.emailAddress,
                            validator: Validations.validateName,
                            onSaved: (String? val) {
                              viewModel.setUsername(val);
                            },
                            focusNode: viewModel.usernameFN,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: new Key('email'),
                            enabled: !viewModel.loading,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white70,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                            autocorrect: true,
                            cursorColor: Colors.white,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.9)),
                            keyboardType: TextInputType.emailAddress,
                            validator: Validations.validateEmail,
                            onSaved: (String? val) {
                              viewModel.setEmail(val);
                            },
                            focusNode: viewModel.emailFN,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: new Key('password'),
                            enabled: !viewModel.loading,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white70,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                },
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                            obscureText: isObscureText,
                            autocorrect: false,
                            enableSuggestions: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: Validations.validatePassword,
                            onSaved: (String? val) {
                              viewModel.setPassword(val);
                            },
                            focusNode: viewModel.passFN,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            key: new Key('confirmPassword'),
                            enabled: !viewModel.loading,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white70,
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              errorStyle: TextStyle(color: Colors.white),
                            ),
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: Validations.validatePassword,
                            onSaved: (String? val) {
                              viewModel.setConfirmPass(val);
                            },
                            focusNode: viewModel.cPassFN,
                            onEditingComplete: () =>
                                FocusScope.of(context).unfocus(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () => viewModel.register(context),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        HexColor("CB2B93"),
                                        HexColor("9546C4"),
                                        HexColor("5E61F4")
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AlreadyHaveAnAccountCheck(
                            press: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            },
                            login: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
