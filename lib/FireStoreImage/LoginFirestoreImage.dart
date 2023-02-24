import 'package:firebase/FireStoreChat/stream_firebase.dart';
import 'package:firebase/FireStoreImage/RegisterFirestoreImage.dart';
import 'package:firebase/FireStoreImage/StoreData.dart';
import 'package:firebase/RegisterLoginFirestore/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class LoginFirestoreImg extends StatelessWidget {
  LoginFirestoreImg({
    Key? key,
  }) : super(key: key);
//final uid;
  Controller counterController = Get.find();
  FirebaseAuth author = FirebaseAuth.instance;
  final Email = TextEditingController();

  final password = TextEditingController();
  final globel = GlobalKey<FormState>();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: globel,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: Email,
                  validator: (value) {
                    // bool emailValid = RegExp(
                    //     "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //     .hasMatch(value!);
                    // if (emailValid) {
                    //   return null;
                    // } else

                    if (value!.isEmpty) {
                      return "Email Can't be empty";
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
                Obx(
                  () => TextFormField(
                    obscureText: counterController.loading1.value,
                    maxLength: 6,
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password Can't be empty";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            counterController.loading1.value =
                                !counterController.loading1.value;
                          },
                          child: counterController.loading1.value == false
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GetBuilder<Controller>(
                  builder: (controller) {
                    return controller.loading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () async {
                              if (globel.currentState!.validate()) {
                                controller.loddder(true);
                                try {
                                  var userCredentials =
                                      await author.signInWithEmailAndPassword(
                                          email: "${Email.text}",
                                          password: "${password.text}");
                                  controller.loddder(false);

                                  print('${userCredentials.user!.email}');

                                  box.write(
                                      'userid', '${userCredentials.user!.uid}');

                                  //Get.to(HomeScreen());
                                  Get.off(StreamFirebaseImg());
                                } on FirebaseAuthException catch (e) {
                                  Get.snackbar('', "${e.message}");
                                  controller.loddder(false);
                                }
                                //Get.to(DemoFireStore(Uid: "${}",));
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.blue,
                              ),
                              child: Center(
                                  child: Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              )),
                            ),
                          );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do not Account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(RegisterFireStoreImg(
                              //key: uid,
                              ));
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
