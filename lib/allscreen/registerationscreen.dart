import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:pms_apc/ScreenSplashes/log_in.dart';
// import 'Data.dart';
import 'package:path/path.dart';

import 'data.dart';
import 'loginscreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

List<String> emp_list = [];

class _RegisterState extends State<Register> {
  dynamic groupValue, value = '';
  bool ans;
  int _state = 0;
  bool __passwordVisible1 = false;
  bool __passwordVisible2 = false;

  @override
  void initState() {
    super.initState();
    groupValue = 0;
    value = 'driver';
    __passwordVisible1 = false;
    __passwordVisible2 = false;
    ans = true;
  }

  Widget function(var a) {
    if (a == true) {
      return Column(
        children: [
          SizedBox(height: 15),

          // TextFor

          SizedBox(height: 15),

          // TextFormField(
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       // Data.edu = 'STK';
          //       return 'Please fill this field';
          //     }

          //     return null;
          //   },
          //   textInputAction: TextInputAction.next,
          //   onTap: () async {

          //   },
          //   onChanged: (value) => Data.edu = value,
          //   readOnly: true,
          //   decoration: InputDecoration(
          //     labelText: 'Study',
          //     floatingLabelBehavior: FloatingLabelBehavior.auto,
          //     border: OutlineInputBorder(),
          //     prefixIcon: Icon(Icons.school),
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
        ],
      );
    } else if (a == false) {
      return Padding(
        padding: EdgeInsets.only(bottom: 9),
        // child:
      );
    } else
      return null;
  }

  File _image;
  CollectionReference _auth = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();

  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50);
  //   //print('Image Path : ${image.path}');
  //   image = await ImageCropper.cropImage(
  //     sourcePath: image.path,
  //     androidUiSettings: AndroidUiSettings(
  //         lockAspectRatio: true,
  //         initAspectRatio: CropAspectRatioPreset.square,
  //         hideBottomControls: true),
  //   );

  //   if (image != null)
  //     setState(() {
  //       _image = image;
  //       //print('Image Path $_image');
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    // Future uploadPic(BuildContext context) async {
    //   try {
    //     String fileName = basename(_image.path);

    //     StorageReference firebaseStorageRef =
    //         FirebaseStorage.instance.ref().child('Users/$fileName');
    //     StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    //     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    //     String download = await taskSnapshot.ref.getDownloadURL();
    //     setState(() {
    //       Data.dp = download;
    //     });
    //   } catch (e) {
    //     Data.showToast("Error In Uploading,Please Try again in Next Day");
    //     Navigator.of(context).pop();
    //   }
    // }

    Future<int> RegisterAndSendEmailVerification() async {
      UserCredential userCredential;
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: Data.email, password: Data.passwd)
            .then(
          (value) async {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: Data.email, password: Data.passwd)
                .then(
              (value) async {
                // await uploadPic(context);
                //print('<<<<<Uploading User Data >>>>>> started');
                await _auth.doc(Data.getUid()).set({
                  'name': Data.name,
                  'email': Data.email,
                  'role': Data.role,
                  'mob': Data.mob,
                  'id': Data.getUid(),
                }).then(
                  (val) {
                    //print("<<<<<<<  UPLOAD user data >>>>>>   completed");
                    Data.showToast('Registration is Successful...');
                    FirebaseAuth.instance.currentUser.sendEmailVerification();
                    Data.showToast(
                        'E-Mail Verification Code is Sent to Your E-mail Address');
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()),
                        (route) => false);
                  },
                );
              },
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Data.showToast('The password provided is too weak.');
          _state = 0;
        } else if (e.code == 'email-already-in-use') {
          Data.showToast('The account already exists for that email.');
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Login()),
              (route) => false);
        } else {
          Data.showToast(e.message);
          //print("Inside else");
        }
      } catch (e) {
        Data.showToast("Error : ${e.toString()}");
      }

      return 1;
    }

    Firebase.initializeApp();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Data.primaryColor,
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(18.0),

                // color: Colors.orange[200],
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'New Registration',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 26,
                            color: Data.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
//
                      // GestureDetector(
                      //   onTap: () {
                      //     getImage();
                      //   },
                      //   child: CircleAvatar(
                      //     backgroundColor: Colors.white,
                      //     child: Padding(
                      //       padding: EdgeInsets.fromLTRB(60, 60, 0, 0),
                      //       child: Icon(
                      //         Icons.cloud_upload,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     backgroundImage: (_image != null)
                      //         ? FileImage(_image)
                      //         : AssetImage('images/profile_default.png'),
                      //     radius: 55,
                      //   ),
                      // ),
                      // Text('Choose Image'),
                      SizedBox(height: 15),

                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill this field';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => Data.name = value,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                      ),
                      SizedBox(height: 15),

                      // SizedBox(height: 15),

                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill this field';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => Data.mob = value,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.call),
                        ),
                      ),
                      // SizedBox(height: 15),
// User type Not Neede because swami ae alag alag app banavvani kidhi chhe for STUDENT AND STAFF

                      Column(
                        // textDirection: TextDirection.ltr,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              child: Text('User Type'),
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                              border: Border.all(
                                  style: BorderStyle.solid, color: Colors.grey),
                              // color: Colors.amber,
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: groupValue,
                                  onChanged: (arg) {
                                    setState(() {
                                      groupValue = arg;
                                      value = "driver";
                                      ans = true;
                                      Data.role = value;
                                      //print("student........${Data.role}");
                                      // Data.role = arg;
                                    });
                                  },
                                ),
                                Text('driver'),
                                Radio(
                                  value: 1,
                                  groupValue: groupValue,
                                  onChanged: (arg) {
                                    setState(() {
                                      groupValue = arg;
                                      value = "passenger";
                                      ans = false;
                                      Data.role = value;
                                      //print("sant....${Data.role}");
                                      // Data.role = arg;
                                    });
                                  },
                                  // //print('<<<<<<>>>>>>>$value');
                                ),
                                Text('passenger')
                              ],
                            ),
                          ),
// ROoM NUMBER
                          //for s it is false

                          SizedBox(height: 15),

                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please fill this field';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            // onFieldSubmitted: (value) =>
                            //     FocusScope.of(context).nextFocus(),
                            decoration: InputDecoration(
                              labelText: 'E-Mail',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_sharp),
                            ),
                            onChanged: (value) => Data.email = value,
                          ),
                          SizedBox(height: 15),
//  PASSWORD
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please fill this field.';
                              } else if (value.length < 6) {
                                return 'Password should be at least of 6 characters';
                              }

                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            // onFieldSubmitted: (value) =>
                            //     FocusScope.of(context).nextFocus(),
                            obscureText: !__passwordVisible1,
                            onChanged: (value) => Data.passwd = value,

                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  __passwordVisible1
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    __passwordVisible1 = !__passwordVisible1;
                                  });
                                },
                              ),

                              labelText: 'Password',
                              // hoverColor: Colors.white,
                              // fillColor: Colors.white,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.vpn_key),
                            ),
                          ),
                          SizedBox(height: 15),

                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please fill this field';
                              } else if (value != Data.passwd) {
                                return 'Password mismatch';
                              }

                              return null;
                            },
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            textInputAction: TextInputAction.done,
                            obscureText: !__passwordVisible2,
                            onChanged: (value) => Data.cpasswd = value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  __passwordVisible2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    __passwordVisible2 = !__passwordVisible2;
                                  });
                                },
                              ),

                              labelText: 'Confirm Password',
                              // hoverColor: Colors.white,
                              // fillColor: Colors.white,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.vpn_key),
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            height: 38,
                            width: double.infinity,
                            child: new MaterialButton(
                              child: setUpButtonChild(),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (Data.passwd == Data.cpasswd) {
                                    _state = 0;
                                    setState(() {
                                      if (_state == 0) {
                                        animateButton();
                                      }
                                    });
                                    RegisterAndSendEmailVerification();
                                  } else {
                                    Data.showToast(
                                        "Password do not match with confirm Pasword!");
                                  }
                                } else {
                                  Data.showToast('Please fill all fields');
                                }
                              },
                              textColor: Colors.white,
                              elevation: 6,
                              splashColor: Colors.orange,
                              //minWidth: double.infinity,
                              height: 68.0,
                              color: Data.primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'have an Account?Sign In Here',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Data.primaryColor),
                            ),
                          ),
                        ],
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
        "REGISTER",
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
