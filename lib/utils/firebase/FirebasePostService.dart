import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:tik_tok_clone_app/model/UserModel.dart';
import 'package:tik_tok_clone_app/utils/file_utils.dart';
import 'package:tik_tok_clone_app/utils/firebase/FirebaseUtils.dart';
import 'package:tik_tok_clone_app/utils/services/Services.dart';
import 'package:uuid/uuid.dart';

class FirebasePostService extends Service {
  UserModel? user;
  String postId = Uuid().v4();

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  uploadProfilePicture(File image, User user) async {
    String link = await uploadImage(profilePic, image);
    var ref = usersRef.doc(user.uid);
    ref.update({
      "photoUrl":
          link.isEmpty ? 'https://images.app.goo.gl/NGh74PqviFBNwFV4A' : link,
    });
  }

  Future<String> uploadImage(Reference ref, File file) async {
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }
}
