import 'package:firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth author = FirebaseAuth.instance;
  final Email = TextEditingController();
  final password = TextEditingController();
  final globel = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: globel,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: Email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Email !!!";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Password !!!";
                  } else if (value.length < 8) {
                    return "Password length more than 8 characters";
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              loading
                  ? GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        if (globel.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            var userCredentials =
                                await author.createUserWithEmailAndPassword(
                                    email: "${Email.text}",
                                    password: "${password.text}");
                            setState(() {
                              loading = false;
                            });

                            print('${userCredentials.user!.email}');

                            Get.defaultDialog(
                                title: "Register",
                                middleText: "Successfully registered!");
                          } on FirebaseAuthException catch (e) {
                            Get.snackbar('', "${e.message}");
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already account ? ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(LoginScreen());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
