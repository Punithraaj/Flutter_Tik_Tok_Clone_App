import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_clone_app/module/profile/ProfileViewChangeNotifier.dart';

class UploadProfilePictureScreen extends StatefulWidget {
  UploadProfilePictureScreen({Key? key}) : super(key: key);

  @override
  _UploadProfilePictureScreenState createState() =>
      _UploadProfilePictureScreenState();
}

class _UploadProfilePictureScreenState
    extends State<UploadProfilePictureScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileViewChangeNotifier viewModel =
        Provider.of<ProfileViewChangeNotifier>(context);
    return WillPopScope(
        onWillPop: () async {
          viewModel.resetPost();
          return true;
        },
        child: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(),
          inAsyncCall: viewModel.loading,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              HexColor("CB2B93"),
              HexColor("9546C4"),
              HexColor("5E61F4"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              key: viewModel.scaffoldKey,
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30),
                children: [
                  GestureDetector(
                    onTap: () => showImageChoices(context, viewModel),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 100.0),
                      child: Column(children: [
                        viewModel.profileImgLink != null
                            ? CircleAvatar(
                                radius: 120,
                                backgroundColor: Colors.black.withOpacity(0.1),
                                backgroundImage:
                                    NetworkImage(viewModel.profileImgLink!),
                              )
                            : viewModel.mediaUrl == null
                                ? Stack(
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                          radius: 120,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          child: Icon(
                                            FontAwesomeIcons.user,
                                            color: Colors.grey.shade700,
                                            size: 100,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 120,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          child: Icon(
                                            FontAwesomeIcons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                          radius: 120,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          backgroundImage:
                                              FileImage(viewModel.mediaUrl!),
                                        ),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 120,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          child: Icon(
                                            FontAwesomeIcons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Upload Your Profile Photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () => viewModel.uplaodProfilePicture(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  HexColor("CB2B93"),
                                  HexColor("9546C4"),
                                  HexColor("5E61F4"),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 10.0),
                          alignment: Alignment.center,
                          child: Text(
                            'done'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  showImageChoices(BuildContext context, ProfileViewChangeNotifier viewModel) {
    showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Select'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                ListTile(
                    leading: Icon(FontAwesomeIcons.camera),
                    title: Text(
                      'Camera',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      viewModel.pickImage(ImageSource.camera);
                    }),
                ListTile(
                    leading: Icon(FontAwesomeIcons.image),
                    title: Text(
                      'Gallery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      viewModel.pickImage(ImageSource.gallery);
                    })
              ],
            ),
          );
        });
  }
}
