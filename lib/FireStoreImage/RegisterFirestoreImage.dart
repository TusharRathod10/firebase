import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/FireStoreImage/LoginFirestoreImage.dart';
import 'package:firebase/FireStoreImage/StoreData.dart';
import 'package:firebase/RegisterLoginFirestore/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class RegisterFireStoreImg extends StatefulWidget {
  RegisterFireStoreImg({Key? key}) : super(key: key);

  @override
  State<RegisterFireStoreImg> createState() => _RegisterFireStoreImgState();
}

class _RegisterFireStoreImgState extends State<RegisterFireStoreImg> {
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  FirebaseAuth author = FirebaseAuth.instance;
  Controller _controller = Get.find();
  final Email = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final globel = GlobalKey<FormState>();

  final box = GetStorage();
  File? file;
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
                  "Register",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        file == null
                            ? SizedBox()
                            : Image.file(file!, fit: BoxFit.cover),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () async {
                              final ImagePicker _picker = ImagePicker();
                              // Pick an image
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              file = File(image!.path);
                              setState(() {});
                            },
                            icon:
                                file != null ? SizedBox() : Icon(Icons.camera),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: firstname,
                  validator: (value) {
                    // bool emailValid = RegExp(
                    //     "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //     .hasMatch(value!);
                    // if (emailValid) {
                    //   return null;
                    // } else

                    if (value!.isEmpty) {
                      return "name Can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "FirstName",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: lastname,
                  validator: (value) {
                    // bool emailValid = RegExp(
                    //     "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //     .hasMatch(value!);
                    // if (emailValid) {
                    //   return null;
                    // } else

                    if (value!.isEmpty) {
                      return "name Can't be empty";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Lastname",
                      prefixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: 40,
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
                    obscureText: _controller.loading1.value,
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
                            _controller.loading1.value =
                                !_controller.loading1.value;
                          },
                          child: _controller.loading1.value == false
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
                  height: 10,
                ),
                GetBuilder<Controller>(
                  builder: (controller) {
                    return controller.loading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () async {
                              if (globel.currentState!.validate()) {
                                setState(() {
                                  controller.loddder(true);
                                });
                                try {
                                  var userCredentials = await author
                                      .createUserWithEmailAndPassword(
                                          email: "${Email.text}",
                                          password: "${password.text}");
                                  setState(() {
                                    controller.loddder(false);
                                  });
                                  // Avtar
                                  var storage = await FirebaseStorage.instance
                                      .ref('${userCredentials.user!.uid}.png');

                                  String url = '';

                                  await storage.putFile(file!).then((p0) async {
                                    url = await storage.getDownloadURL();
                                  });

                                  user.doc('${userCredentials.user!.uid}').set({
                                    'firstname': '${firstname.text}',
                                    'lastname': '${lastname.text}',
                                    'email': '${Email.text}',
                                    'profile': "$url",
                                  });

                                  box.write(
                                      'userid', '${userCredentials.user!.uid}');

                                  Get.off(StreamFirebaseImg());
                                  print('${userCredentials.user!.email}');
                                } on FirebaseAuthException catch (e) {
                                  Get.snackbar('', "${e.message}");
                                  setState(() {
                                    controller.loddder(false);
                                  });
                                }

                                // Get.snackbar("Email", "SuccessFully Sign UP!!!!");

                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text("SuccessFully Sign UP!!!!")));
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
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              )),
                            ),
                          );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(LoginFirestoreImg());
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
