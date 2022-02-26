import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tik_tok_clone_app/module/MainScreen.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebasePostService.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseUtils.dart';

class ProfileViewChangeNotifier extends ChangeNotifier {
  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Variables
  bool loading = false;
  File? mediaUrl;
  final ImagePicker imagePicker = ImagePicker();
  late File userProfilePic;
  String? profileImgLink;

  void resetPost() {
    mediaUrl = null;
    notifyListeners();
  }

  void showInSnackbar(String value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  uplaodProfilePicture(BuildContext context) async {
    if (mediaUrl == null) {
      showInSnackBar('Please Select an image');
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
        showInSnackBar('Uploading Profic Pic Successful');
      } catch (e) {
        loading = false;
        notifyListeners();
        showInSnackBar('Uploading Profic Pic Unsuccessful');
      }
    }
  }

  pickImage(ImageSource source) async {
    loading = true;
    notifyListeners();
    try {
      XFile? pickedFile = await imagePicker.pickImage(source: source);
      File? croppedFile;

      ImageCompressFormat compressFormat = ImageCompressFormat.jpg;
      if (pickedFile != null) {
        if (path.extension(pickedFile.path) == ".png") {
          compressFormat = ImageCompressFormat.png;
        }

        croppedFile = await ImageCropper.cropImage(
            sourcePath: pickedFile.path,
            androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              toolbarTitle: "Edit Photo",
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
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

  void showInSnackBar(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }
}
