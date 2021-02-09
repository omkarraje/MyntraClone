/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String s;
String messagenumber;
String messagename;

void getname(String title) async {
  List<String> s;
  await for (var snapshot
      in FirebaseFirestore.instance.collection(title).snapshots()) {
    final message = snapshot.docs;
    for (var messages in message) {
      messagename = messages.data()['name'];
      messagenumber = messages.data()['phone'];
      print(messagename + '\n\n\n\n\n\n');
      print(messagenumber + '\n\n\n\n\n\n');
    }
  }
}

class P2 extends StatefulWidget {
  P2(this.title) {
    s = title;
    getname(title);
  }

  final String title;

  @override
  _P2State createState() => _P2State();
}

class _P2State extends State<P2> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    getname(widget.title);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 50.00,
        backgroundColor: Colors.amber,
        shape: StadiumBorder(),
        title: Text(
          'name  - $messagename   \nnumber - $messagenumber',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

Widget ProfilePages() {
  //  StorageReference ref = FirebaseStorage.instance.ref();
  final ref = FirebaseStorage.instance
      .ref()
      .child('image_picker8586663316314216688.jpg');
  return FutureBuilder(
      future: ref.getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          print("\n\n\n\n\n\n\n" + snapshot.data + "\n\n\n\n\n\n");
          return new Image.network(snapshot.data, fit: BoxFit.fill);
        }
        return CircularProgressIndicator();
      });
}

class ProfilePage extends StatefulWidget {
  ProfilePage() {}

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  var s;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);

      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 100.0),
          children: [
            ListTile(
              leading: ProfilePages(),
              title: Text('GYM WORKOUT'),
            ),
            ListTile(
              leading: ProfilePages(),
              title: Text('GYM WORKOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
