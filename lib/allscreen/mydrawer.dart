import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/allscreen/mapscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDrawer extends StatelessWidget {
  String accountName, accountEmail;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
          future: userDrawer(),
          builder: (context, snapshot) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(accountName),
                  accountEmail: Text(accountEmail),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("images/1.jpg"),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Account'),
                  subtitle: Text('Personal'),
                  trailing: Icon(Icons.send),
                ),
                ListTile(
                  leading: Icon(Icons.domain_verification),
                  title: Text('Map'),
                  subtitle: Text('Find Cab Here'),
                  trailing: Icon(Icons.verified),
                  onTap: () {
                    Fluttertoast.showToast(msg: "This is My MapScreen");
                    Navigator.pushNamed(context, '/MyMapScreen');
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.add),
                //   title: Text('My Map1'),
                //   onTap: () {
                //     Fluttertoast.showToast(msg: "My Map1");
                //     Navigator.pushNamedAndRemoveUntil(
                //         context, '/MyMapScreen1', (route) => true);
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('message'),
                  onTap: () {
                    Fluttertoast.showToast(msg: "message Pressed");
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/addcloth', (route) => true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('My Balance'),
                  onTap: () {
                    Fluttertoast.showToast(msg: "My Balance Pressed");
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/addcloth', (route) => true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Help Pressed");
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/addcloth', (route) => true);
                  },
                ),
              ],
            );
          }),
    );
  }

  Future userDrawer() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    Map<String, dynamic> data = snapshot.data();
    accountEmail = data['email'];
    accountName = data['name'];
  }
}
