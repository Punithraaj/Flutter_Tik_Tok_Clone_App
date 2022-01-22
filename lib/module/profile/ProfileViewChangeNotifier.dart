import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
// import 'package:flutter_tiktok/services/post_service.dart';
// import 'package:flutter_tiktok/utils/const.dart';
// import 'package:flutter_tiktok/utils/firebase/firebase.dart';
// import 'package:flutter_tiktok/view/screens/mainscreen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tik_tok_clone_app/module/MainScreen.dart';
import 'package:tik_tok_clone_app/utils/constants.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebasePostService.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseUtils.dart';

class ProfileViewModel extends ChangeNotifier {
  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variables
  bool loading = false;
  File? mediaUrl;
  final ImagePicker imagePicker = ImagePicker();
  late File userDp;
  String? imgLink;

  //Functions
  pickImage(ImageSource source) async {
    loading = true;
    notifyListeners();
    try {
      XFile? pickedFile = await imagePicker.pickImage(
        source: source,
      );

      File? croppedFile;
      ImageCompressFormat compressFormat = ImageCompressFormat.jpg;
      if (pickedFile != null) {
        print("Jpg = " + path.extension(pickedFile.path));
        if (path.extension(pickedFile.path) == '.png') {
          compressFormat = ImageCompressFormat.png;
        }

        croppedFile = await ImageCropper.cropImage(
            androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              toolbarTitle: "Edit Photo",
              // toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
            sourcePath: pickedFile.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            compressFormat: compressFormat);
      }
      mediaUrl = croppedFile == null
          ? (pickedFile == null ? null : File(pickedFile.path))
          : File(croppedFile.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled');
    }
  }

  uploadProfilePicture(BuildContext context) async {
    if (mediaUrl == null) {
      showInSnackBar('Please select an image');
    } else {
      try {
        loading = true;
        notifyListeners();
        await FirebasePostService()
            .uploadProfilePicture(mediaUrl!, firebaseAuth.currentUser!);
        loading = false;
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
        notifyListeners();
      } catch (e) {
        print(e);
        loading = false;
        showInSnackBar('Uploaded successfully!');
        notifyListeners();
      }
    }
  }

  resetPost() {
    mediaUrl = null;
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
