import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pro/P1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pro/P2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'P2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ProfilePage(),
        '/first': (context) => mains(),
      },
    );
  }
}

class mains extends StatefulWidget {
  @override
  _mainsState createState() => _mainsState();
}

class _mainsState extends State<mains> {
  get crossaxisAlignment => null;
  final auth = FirebaseAuth.instance;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllernumber = TextEditingController();
  TextEditingController _controlleremail = TextEditingController();
  // final formKey = new GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String passward;
  String passwardnumber;
  String passwardemail;
  int a = 0;
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String phoneNo;
  String smsCode;
  String verificationId;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;
  final _firestore = FirebaseFirestore.instance;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => P1()));
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (user) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser;
                  try {
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => P1()));
                      //    Navigator.of(context).pop();
                      //     Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          );
        });
  }

  signIn() {
    FirebaseAuth.instance.signInWithPhoneNumber(verificationId).then((user) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => P1()));
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 150.0),
          child: Card(
            borderOnForeground: true,
            elevation: 30.0,
            shadowColor: Colors.blueAccent,
            color: Colors.blueAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    child: Text(
                  "Account Create",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _controlleremail,
                      decoration: InputDecoration(
                        hintText: "Enter Valid Email ",
                        errorText: passwardemail,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                        labelText: ("Email"),
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.mail),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _controllernumber,
                      decoration: InputDecoration(
                        hintText: "Enter Valid number ",
                        errorText: passwardnumber,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                        labelText: ("Number"),
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.call),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _controllerName,
                      decoration: InputDecoration(
                        hintText: "Upper case ",
                        errorText: passward,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                        labelText: ("Name"),
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Size must be 6",
                        errorText: passward,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                        labelText: ("Passward"),
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                      )),
                ),
                RaisedButton(
                    color: Colors.redAccent,
                    shape: StadiumBorder(),
                    splashColor: Colors.white,
                    onPressed: () async {
                      a = 0;

                      setState(() {
                        print(_controllerName.text);
                        _controllerName.text =
                            _controllerName.text.toUpperCase();
                        a = a + 100;
                      });

                      setState(() {
                        if (_controller.text.length < 8) {
                          passward = "please enter valid passward ";
                        } else {
                          passward = null;
                          a = a + 200;
                        }
                      });
                      setState(() {
                        if (!_controlleremail.text.contains('@')) {
                          passwardemail = "please enter valid email ";
                        } else {
                          passwardemail = null;
                          a = a + 20;
                        }
                      });
                      setState(() {
                        if (_controllernumber.text.length < 10) {
                          passwardnumber = "length should be 10 ";
                        } else {
                          passwardnumber = null;
                          a = a + 70;
                        }
                      });
                      //          Navigator.push(
                      //            context, MaterialPageRoute(builder: (context) => P1()));

                      if (a == 390) {
                        try {
                          this.phoneNo = _controllernumber.text;
                          verifyPhone();
                          final newuser =
                              await auth.createUserWithEmailAndPassword(
                                  email: _controlleremail.text,
                                  password: _controller.text);
                          name = _controllerName.text;
                          String s = _controlleremail.text;
                          String s2 = s + '2';
                          _firestore.collection(s).add({
                            'name': name,
                            'phone': _controllernumber.text,
                            'phone2': _controllernumber.text
                          });
                          if (newuser != null) {
                            //    Navigator.pushNamed(context, '/');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
