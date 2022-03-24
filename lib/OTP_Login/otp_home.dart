import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpAppHome extends StatelessWidget {
  late final User? user;
  String name;


  OtpAppHome(this.user, this.name);

//  const user.displayName = name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Text("You are Logged in Succesfully", style: TextStyle(color: Colors.lightBlue, fontSize: 32),)),
            SizedBox(height: 16,),
            Center(child: Text("$name", style: TextStyle(color: Colors.grey, fontSize: 32 ),)),
          ],
        ),
      ),
    );
  }
}


