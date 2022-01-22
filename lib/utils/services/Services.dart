// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:tik_tok_clone_app/utils/file_utils.dart';
// import 'package:tik_tok_clone_app/utils/firebase/FirebaseAuthService.dart';

// abstract class Service {
//   Future<String> uploadImage(Reference ref, File file) async {
//     String ext = FileUtils.getFileExtension(file);
//     Reference storageReference = ref.child("${uuid.v4()}.$ext");
//     UploadTask uploadTask = storageReference.putFile(file);
//     await uploadTask.whenComplete(() => null);
//     String fileUrl = await storageReference.getDownloadURL();
//     return fileUrl;
//   } 
// }
