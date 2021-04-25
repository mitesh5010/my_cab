import 'dart:async';

import 'package:cab_app/allscreen/mainscreen.dart';
import 'package:cab_app/allscreen/mapscreen.dart';
import 'package:cab_app/allscreen/registerationscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'data.dart';
import 'forgetpassword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // String email, passwd;
  TextEditingController email, passwd;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool __passwordVisible = false;
  int _state = 0;

  @override
  void initState() {
    email = TextEditingController();
    passwd = TextEditingController();

    // super.initState();

    clear = true;
    __passwordVisible = false;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DateTime current;

  Future<bool> popped() {
    DateTime now = DateTime.now();
    if (current == null || now.difference(current) > Duration(seconds: 2)) {
      current = now;
      Data.showToast('Press back again to exit!');
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  bool click = false;
  bool clear;
  Future<bool> validateAndException() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: passwd.text.trim())
          .then((value) async {
        print("Signed In");
        var snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(Data.getUid())
            .get();
        Map<String, dynamic> data = snapshot.data();
        if (!auth.currentUser.emailVerified) {
          _state = 0;
          auth.currentUser.sendEmailVerification();
          Data.showToast(
              'Please Verify your E-Mail Address,we send new verification link to Your E-mail');
          FirebaseAuth.instance.signOut();
        } else {
          Data.email = data['email'];
          Data.name = data['name'];

          Data.mob = data['mob'];

          Data.role = data['role'];

          Data.showToast('Login Sucessfull');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => MyHomePage()));
          //  else {
          //   FirebaseAuth.instance.signOut();
          //   _state = 0;
          //   Data.showToast('User not verified by Admin');
          // }
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _state = 0;
        Data.showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _state = 0;
        Data.showToast('Wrong password provided for that user.');
      } else {
        _state = 0;
        Data.showToast(e.message);
      }
    }

    return Future<bool>.value(true);
  }

  String documentId;

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('images/LoginBack.png'), context);
    var gestureDetector = GestureDetector(
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.grey[700]),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgetPassword()));
        });
    return WillPopScope(
      onWillPop: () => popped(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/LoginBack.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
            reverse: true,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(17, 11, 49, 1).withOpacity(0),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sign In',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        cursorColor: Colors.orangeAccent,
                        autofocus: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.trim().isNotEmpty) return null;
                          return 'Please fill this field.';
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo, width: 2), //starting
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo, width: 2), //onwriting
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 8),
                          labelStyle:
                              TextStyle(color: Colors.indigo, fontSize: 16),
                          prefixIcon: Icon(
                            Icons.email_sharp,
                            color: Colors.indigo,
                          ),
                          fillColor: Colors.white,
                          labelText: 'E-Mail',
                        ),
                        controller: email,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        cursorColor: Colors.orangeAccent,
                        style: TextStyle(color: Colors.black, fontSize: 16),

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.trim().isNotEmpty) {
                            return null;
                          }
                          return 'Please fill this field.';
                        },
                        // focusNode: FocusNode(canRequestFocus: true),
                        obscureText: !__passwordVisible,
                        controller: passwd,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key, color: Colors.indigo),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo, width: 2), //starting
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 2), //onwriting
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 8),
                          labelStyle:
                              TextStyle(color: Colors.indigo, fontSize: 16),
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              __passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.indigo,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                __passwordVisible = !__passwordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 38,
                        width: double.infinity,
                        child: MaterialButton(
                            child: setUpButtonChild(),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _state = 0;
                                setState(() {
                                  if (_state == 0) {
                                    animateButton();
                                  }
                                });
                                validateAndException();
                              }
                            },
                            textColor: Colors.white,
                            elevation: 6,
                            splashColor: Colors.orange,
                            //minWidth: double.infinity,
                            height: 68.0,
                            color: Colors.indigo),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: gestureDetector,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            // valueColor: Colors.amber,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ));
                        },
                        child: Text(
                          'New User? Register Here',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(minutes: 20), () {
      setState(() {
        _state = 2;
      });
    });
  }

  Widget setUpButtonChild() {
    if (_state != 1) {
      return new Text(
        "Sign In ",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }
}
