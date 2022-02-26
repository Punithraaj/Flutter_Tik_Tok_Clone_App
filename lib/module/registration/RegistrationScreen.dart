import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_clone_app/module/login/LoginScreen.dart';
import 'package:tik_tok_clone_app/module/registration/RegistrationScreenNotifier.dart';
import 'package:tik_tok_clone_app/utils/Validations.dart';
import 'package:tik_tok_clone_app/utils/widgets/AlreadyHaveAnAccountCheck.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isObsecureText = true;
  bool isConfirmObsecureText = true;
  @override
  Widget build(BuildContext context) {
    final RegistrationScreenNotifier viewModel =
        Provider.of<RegistrationScreenNotifier>(context);
    final Size deviceScreenConfig = MediaQuery.of(context).size;
    return ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(),
        inAsyncCall: viewModel.loading,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              height: deviceScreenConfig.height,
              width: deviceScreenConfig.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                HexColor("CB2B93"),
                HexColor("9546C4"),
                HexColor("5E61F4"),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.15, 20, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/musical-note.png',
                            fit: BoxFit.fitWidth,
                            height: 150,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: viewModel.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                key: new Key('userName'),
                                enabled: !viewModel.loading,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_outline,
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
                                          width: 0, style: BorderStyle.none),
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)),
                                autocorrect: true,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                keyboardType: TextInputType.emailAddress,
                                validator: Validations.validateName,
                                onSaved: (String? val) {
                                  setState(() {
                                    viewModel.setUserName(val);
                                  });
                                },
                                focusNode: viewModel.userNameFN,
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                key: new Key('email'),
                                enabled: !viewModel.loading,
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
                                          width: 0, style: BorderStyle.none),
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)),
                                autocorrect: true,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                keyboardType: TextInputType.emailAddress,
                                validator: Validations.validateEmail,
                                onSaved: (String? val) {
                                  setState(() {
                                    viewModel.setEmail(val);
                                  });
                                },
                                focusNode: viewModel.emailFN,
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                key: new Key('password'),
                                enabled: !viewModel.loading,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white70,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isObsecureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white70,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isObsecureText = !isObsecureText;
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
                                          width: 0, style: BorderStyle.none),
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)),
                                autocorrect: true,
                                obscureText: isObsecureText,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                keyboardType: TextInputType.visiblePassword,
                                validator: Validations.validatePassword,
                                onSaved: (String? val) {
                                  setState(() {
                                    viewModel.setPassword(val);
                                  });
                                },
                                focusNode: viewModel.passFN,
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                key: new Key('confirmPassword'),
                                enabled: !viewModel.loading,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white70,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isConfirmObsecureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white70,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isConfirmObsecureText =
                                              !isConfirmObsecureText;
                                        });
                                      },
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
                                          width: 0, style: BorderStyle.none),
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)),
                                autocorrect: true,
                                obscureText: isConfirmObsecureText,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9)),
                                keyboardType: TextInputType.visiblePassword,
                                validator: Validations.validatePassword,
                                onSaved: (String? val) {
                                  setState(() {
                                    viewModel.setConfirmPassword(val);
                                  });
                                },
                                focusNode: viewModel.confirmPassFN,
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50.0,
                                child: RaisedButton(
                                  onPressed: () => viewModel.register(context),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              HexColor("CB2B93"),
                                              HexColor("9546C4"),
                                              HexColor("5E61F4"),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 300.0,
                                        minHeight: 50.0,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Sign Up",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AlreadyHaveAnAccountCheck(
                                  login: false,
                                  press: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                  }),
                            ],
                          ),
                        ),
                      ])),
            ),
          ),
        ));
  }
}
