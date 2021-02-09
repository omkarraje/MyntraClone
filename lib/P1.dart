import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/main.dart';
import 'package:pro/reset.dart';
import 'P2.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class P1 extends StatefulWidget {
  @override
  _P1State createState() => _P1State();
}

class _P1State extends State<P1> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationController2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.10,
    )..addListener(() {
        setState(() {});
      });
    ;

    _animationController2 = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

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
  bool _isInAsyncCall = false;
  final _firestore = FirebaseFirestore.instance;

//  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void getMessages() async {
    await for (var snapshot in _firestore.collection('omi').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data().cast());
      }
    }
  }

  void getmessasync() async {}

  @override
  Widget build(BuildContext context) {
    double scale1 = 1 + _animationController.value;
    double scale2 = 1 + _animationController2.value;
    int l = 500;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        color: Colors.redAccent,
        child: SingleChildScrollView(
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
                    " Login",
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
                  Row(
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      /*GestureDetector(
                        onTap: () async {
                          a = 0;
                          setState(() {
                            l = 100;

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
                          //          Navigator.push(
                          //            context, MaterialPageRoute(builder: (context) => P1()));
                          if (a == 220) {
                            try {
                              final newuser =
                                  await auth.signInWithEmailAndPassword(
                                      email: _controlleremail.text,
                                      password: _controller.text);
                              if (newuser != null) {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => P2()));
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        onTapUp: onTapUp,
                        onTapDown: onTapDown,
                        onTapCancel: onTapCancel,
                        child: Transform.scale(
                            scale: scale1,
                            */
                      Expanded(
                        child: RaisedButton(
                            color: Colors.red,
                            splashColor: Colors.redAccent[100],
                            shape: StadiumBorder(),
                            elevation: 50.0,
                            onHighlightChanged: (isHigh) {},
                            onPressed: () async {
                              a = 0;

                              setState(() {
                                l = 100;

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
                              //          Navigator.push(
                              //            context, MaterialPageRoute(builder: (context) => P1()));
                              if (a == 220) {
                                try {
                                  final newuser =
                                      await auth.signInWithEmailAndPassword(
                                          email: _controlleremail.text,
                                          password: _controller.text);
                                  if (newuser != null) {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage()));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                              setState(() {
                                _isInAsyncCall = false;
                              });
                            },
                            child:
                                /*Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[l],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.0), //(x,y)
                                        blurRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.all(10.0),
                                child: 
                                */
                                Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  FlatButton(
                      color: Colors.white,
                      highlightColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        getMessages();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => reset()));
                      },
                      child: Text(
                        "Forgot passwaord ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )),
                  FlatButton(
                      color: Colors.white,
                      shape: StadiumBorder(),
                      highlightColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          bool _isInAsyncCall = true;
                        });

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => mains()));
                      },
                      child: Text(
                        "Create an account ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  onTapCancel() {
    _animationController.reverse();
  }

  onTapUp2(TapUpDetails details) {
    _animationController2.reverse();
  }

  onTapDown2(TapDownDetails details) {
    _animationController2.forward();
  }

  onTapCancel2() {
    _animationController2.reverse();
  }
}
