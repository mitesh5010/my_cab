import 'package:cab_app/allscreen/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    }
                    return 'Please fill this field.';
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_sharp),
                  ),
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 38,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      Data.showToast(
                          'Link for Password Reset is SENT to $email');
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email);
                      Navigator.pop(context);
                    },
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    elevation: 6,
                    child: Text(
                      'Send Link to Email',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Button Pressed......................................................................
              ],
            ),
          ),
        ),
      ),
    );
  }
}
