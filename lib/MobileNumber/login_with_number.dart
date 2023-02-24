import 'dart:async';

import 'package:firebase/MobileNumber/verify_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInWithMobile extends StatefulWidget {
  const SignInWithMobile({Key? key}) : super(key: key);

  @override
  State<SignInWithMobile> createState() => _SignInWithMobileState();
}

class _SignInWithMobileState extends State<SignInWithMobile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final number = TextEditingController();
  final global = GlobalKey<FormState>();

  bool resend = false;
  int startTime = 0;

  @override
  void initState() {
    start();
    // TODO: implement initState
    super.initState();
  }

  void start() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      startTime--;

      if (startTime == 0) {
        setState(() {
          resend = true;
          timer.cancel();
        });
      }
    });
  }

  int? reSendToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: global,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Value Can't be empty!";
                  } else if (value.length < 10) {
                    return "Value can't be less than 10 characters";
                  }
                },
                keyboardType: TextInputType.number,
                controller: number,
                maxLength: 10,
                decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (global.currentState!.validate()) {
                    setState(() {
                      auth.verifyPhoneNumber(
                        phoneNumber: '+91' + "${number.text}",
                        verificationCompleted: (phoneAuthCredential) {},
                        verificationFailed: (error) {
                          print(error.message);
                        },
                        codeSent: (verificationId, forceResendingToken) {
                          setState(() {
                            reSendToken = forceResendingToken!;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyOtp(
                                id: verificationId,
                                reSendToken: reSendToken!,
                                number: number.text,
                              ),
                            ),
                          );
                        },
                        forceResendingToken: reSendToken,
                        codeAutoRetrievalTimeout: (verificationId) {},
                      );
                    });
                  }
                },
                child: Text('Send OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
