import 'package:cab_app/allscreen/mydrawer.dart';
import 'package:flutter/material.dart';

class mainscreen extends StatefulWidget {
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("online booking cab"),
      ),
      drawer: MyDrawer(),
      body: Center(
        //box
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          // color: Colors.blue,
          width: 100,
          height: 100,
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blue,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blue[300],
                Colors.purpleAccent,
                Colors.purpleAccent[200],
              ]),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                )
              ]),
          child: Text(
            "MITESH",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          // child: Text("Hii mitesh "),
        ),
      ),
    );
  }
}
