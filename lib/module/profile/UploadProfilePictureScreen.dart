import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_clone_app/module/profile/ProfileViewChangeNotifier.dart';

class UploadProfilePicScreen extends StatefulWidget {
  @override
  UploadProfilePicScreenState createState() => UploadProfilePicScreenState();
}

class UploadProfilePicScreenState extends State<UploadProfilePicScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);
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
            HexColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            key: viewModel.scaffoldKey,
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              children: [
                GestureDetector(
                  onTap: () => showImageChoices(context, viewModel),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 100.0),
                    child: Column(
                      children: [
                        viewModel.imgLink != null
                            ? CircleAvatar(
                                radius: 130.0,
                                backgroundColor: Colors.black.withOpacity(0.1),
                                backgroundImage:
                                    NetworkImage(viewModel.imgLink!),
                              )
                            : viewModel.mediaUrl == null
                                ? Stack(
                                    children: <Widget>[
                                      Center(
                                        child: CircleAvatar(
                                          radius: 130.0,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          child: Icon(
                                            FontAwesomeIcons.user,
                                            color: Colors.grey.shade600,
                                            size: 100,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 130.0,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          child: Icon(
                                            FontAwesomeIcons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Stack(
                                    children: <Widget>[
                                      Center(
                                        child: CircleAvatar(
                                          radius: 130.0,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          backgroundImage: FileImage(
                                            viewModel.mediaUrl!,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 130.0,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.1),
                                          child: Icon(
                                            FontAwesomeIcons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                        SizedBox(height: 10.0),
                        Text(
                          'Upload your Profile Photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
            // ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => viewModel.uploadProfilePicture(context),
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
                        constraints: BoxConstraints(minHeight: 50.0),
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
      ),
    );
  }

  showImageChoices(BuildContext context, ProfileViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(FontAwesomeIcons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
