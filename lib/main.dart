import 'package:firebase/FireStore/fire_store_data.dart';
import 'package:firebase/FireStoreChat/RegisterFirestoreChat.dart';
import 'package:firebase/FireStoreImage/LoginFirestoreImage.dart';
import 'package:firebase/FireStoreImage/StoreData.dart';
import 'package:firebase/Google/google_sign_in.dart';
import 'package:firebase/MobileNumber/login_with_number.dart';
import 'package:firebase/MobileNumber/verify_otp.dart';
import 'package:firebase/RegisterLoginFirestore/RegiterFirestore.dart';
import 'package:firebase/RegisterLoginFirestore/controller.dart';
import 'package:firebase/registration.dart';
import 'package:firebase/select_delete.dart';
import 'package:firebase/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //home: MyApp2(),
      debugShowCheckedModeBanner: false,
      home: GetStorage().read("userid") == null
          ? LoginFirestoreImg()
          : StreamFirebaseImg(),
    );
  }

  Controller counterController = Get.put(Controller());
}
