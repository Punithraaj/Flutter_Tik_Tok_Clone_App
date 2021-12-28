import 'package:flutter/material.dart';
import 'package:tik_tok_clone_app/utils/validations.dart';

class TextFormFieldBuilder extends StatelessWidget {
  final String textFieldkey;
  final bool isEnabled;
  final String labelText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final Function press;
  const TextFormFieldBuilder({
    Key? key,
    required this.textFieldkey,
    required this.isEnabled,
    required this.labelText,
    required this.keyboardType,
    required this.focusNode,
    required this.press,
    required this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: new Key(textFieldkey),
      enabled: isEnabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white70,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        errorStyle: TextStyle(color: Colors.white),
      ),
      autocorrect: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      keyboardType: keyboardType,
      validator: Validations.validateName,
      onSaved: press(),
      focusNode: focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
    );
  }
}
