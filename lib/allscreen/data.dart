import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

// IMPORTANT!!!!!!!!
// DON'T REMOVE ANY ENTRY FROM THIS FILE
// THIS DATA IS USED IN ALL OVER THE APP
class Data {
  static String version = '1.0.4';
  static int t_id = Timestamp.now().microsecondsSinceEpoch;
  static bool darkTheme = false;
  static var name = 'student',
      email = '',
      passwd,
      cpasswd,
      roll,
      room,
      mob,
      edu,
      updated_issue,
      college,
      leader,
      vibhag,
      dp,
      verified = false,
      token = 'APC',
      role,
      task_name = [],
      task_name2 = [],
      //Members of task:
      title,
      people,
      description;

  static void showToast(var msg1) {
    Fluttertoast.showToast(
      msg: msg1,
      // backgroundColor: HexColor("#2f1970"),
      backgroundColor: Colors.orange[600],
      textColor: Colors.white,
    );
  }

  static String getUid() => FirebaseAuth.instance.currentUser.uid;
  static Future<String> futureGetUid() {
    return Future.value(FirebaseAuth.instance.currentUser.uid);
  }

  static bool getBig(id) {}

  static Widget loadingDialog() {
    return Container(
      // color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }

  static Color primaryColor = Color.fromRGBO(47, 25, 112, 1);
  static AppBar myAppbar;
  static setAppbar(index) {
    // if (index != 4) {
    myAppbar = AppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.indigoAccent,
      title: Text('APC Seva'),
    );
  }
}
