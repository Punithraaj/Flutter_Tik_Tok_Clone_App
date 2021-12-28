import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_clone_app/module/login/LoginScreenNotifier.dart';
import 'package:tik_tok_clone_app/module/registration/RegistrationScreen.dart';
import 'package:tik_tok_clone_app/utils/validations.dart';
import 'package:tik_tok_clone_app/utils/widgets/AlreadyHaveAnAccountCheck.dart';
import 'package:tik_tok_clone_app/utils/widgets/OrDivider.dart';
import 'package:tik_tok_clone_app/utils/widgets/SocialIcon.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    LoginScreenNotifier viewModel = Provider.of<LoginScreenNotifier>(context);
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Form(
                key: viewModel.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      height: 40,
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
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none))),
                      autocorrect: true,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
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
                      height: 20,
                    ),
                    TextFormField(
                      key: new Key('password'),
                      enabled: !viewModel.loading,
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
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none))),
                      obscureText: isObscureText,
                      autocorrect: false,
                      enableSuggestions: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validations.validatePassword,
                      onSaved: (String? val) {
                        viewModel.setPassword(val);
                      },
                      focusNode: viewModel.passFN,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () => viewModel.login(context),
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
                              "Login",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                          return RegistrationScreen();
                        }));
                      },
                      login: true,
                    ),
                    OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {},
                        ),
                        SocialIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                        SocialIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
