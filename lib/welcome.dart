import 'package:firebase/Google/google_sign_in.dart';
import 'package:firebase/MobileNumber/login_with_number.dart';
import 'package:firebase/login.dart';
import 'package:firebase/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black, fontSize: 70),
          ),
          SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.to(RegisterScreen());
                },
                child: Image.asset(
                  "assets/images/gmail.png",
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Get.to(SignInWithMobile());
                },
                child: Image.asset(
                  "assets/images/phone-call.png",
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Get.to(GoogleData());
                },
                child: Image.asset(
                  "assets/images/google.png",
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
