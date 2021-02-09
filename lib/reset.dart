import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pro/P2.dart';

class reset extends StatefulWidget {
  @override
  _resetState createState() => _resetState();
}

class _resetState extends State<reset> {
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
//  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                  " Reset passward",
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
                Ink(
                  child: InkWell(
                      onTap: () async {
                        a = 0;

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
                        if (a == 20) {
                          try {
                            auth.sendPasswordResetEmail(
                                email: _controlleremail.text);
                            Navigator.of(context).pop();
                            /*if (newuser != null) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => P2()));
                            }
                            */
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      splashColor: Theme.of(context).primaryColorLight,
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.black,
                          child: Text('Send Request ',
                              style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
