import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({
    Key? key,
    required this.id,
    required this.reSendToken,
    required this.number,
  }) : super(key: key);
  final String id;
  final int reSendToken;
  final String number;

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController otp = TextEditingController();

  bool resend = false;
  int startTime = 30;

  @override
  void initState() {
    start();
    // TODO: implement initState
    super.initState();
  }

  void start() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      startTime -= 1;
      setState(() {});

      if (startTime == 0) {
        setState(() {
          resend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: otp,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    PhoneAuthCredential credentials =
                        PhoneAuthProvider.credential(
                      verificationId: widget.id,
                      smsCode: otp.text,
                    );

                    var userCredentials =
                        await auth.signInWithCredential(credentials);

                    print('${userCredentials.user!.phoneNumber}');
                  },
                  child: Text('Verify'),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () async {
                    auth.verifyPhoneNumber(
                      phoneNumber: '+91' + "${widget.number}",
                      verificationCompleted: (phoneAuthCredential) {},
                      verificationFailed: (error) {
                        print(error.message);
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        setState(() {
                          resend = false;
                          startTime = 30;
                          start();
                        });
                      },
                      forceResendingToken: widget.reSendToken,
                      codeAutoRetrievalTimeout: (verificationId) {},
                    );
                  },
                  child: resend
                      ? Text('Resend Otp')
                      : Text("${startTime} seconds"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
