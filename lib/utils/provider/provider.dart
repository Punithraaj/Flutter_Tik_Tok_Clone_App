import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tik_tok_clone_app/module/login/LoginScreenNotifier.dart';
import 'package:tik_tok_clone_app/module/profile/ProfileViewChangeNotifier.dart';
import 'package:tik_tok_clone_app/module/registration/RegistrationScreenNotifier.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => LoginScreenNotifier()),
  ChangeNotifierProvider(create: (_) => RegistrationScreenNotifier()),
  ChangeNotifierProvider(create: (_) => ProfileViewModel()),
];
