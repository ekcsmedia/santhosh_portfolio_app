import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'otp_home.dart';


class OtpLoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  // final _passController = TextEditingController();
  final _codeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future registerUser(String name, String mobile, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    //Set (name) { user.displayName = name }

    await _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential  credential){
          _auth.signInWithCredential(credential).then((UserCredential result){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => OtpAppHome(result.user, name)
            ));
          }).catchError((e){
            print(e);
          });
        },
        verificationFailed: (FirebaseAuthException e){
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
          print(e.message); }
        },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
            title: Text("Enter SMS Code"),
               content: Column(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                TextField(
                controller: _codeController,
                ), ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    String smsCode = _codeController.text.trim();

                    PhoneAuthCredential  _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                    auth.signInWithCredential(_credential).then((UserCredential result){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => OtpAppHome(result.user, name)
                      ));
                    }).catchError((e){
                      print(e);
                    });
                  },
                )
              ],
            ));
      },
    codeAutoRetrievalTimeout: (String verificationId){
    verificationId = verificationId;
    print(verificationId);
    print("Timeout");
    }); }

    //Place A
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                SizedBox(height: 16,),

                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: const Color (0xBB000000) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: const Color (0xBB000000) )
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Name"

                  ),
                  controller: _nameController,
                ),


                SizedBox(height: 16,),

                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: const Color (0xBB000000) ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: const Color (0xBB000000) )
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Phone Number"

                  ),
                  controller: _phoneController,
                ),

                SizedBox(height: 16,),
/*
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: const Color (0xBB000000))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: const Color (0xBB000000))
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Password"

                  ),

                  controller: _passController,
                ), */

  //              SizedBox(height: 16,),

                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: (){
                      final mobile = _phoneController.text.trim();
                      final name = _nameController.text.trim();
                      registerUser(name, mobile, context);},
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}


