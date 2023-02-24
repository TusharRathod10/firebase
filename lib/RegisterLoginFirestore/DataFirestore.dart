import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/RegisterLoginFirestore/LoginFirestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FireStoreData extends StatefulWidget {
  const FireStoreData(
      {Key? key, this.firstname, this.username, this.email, this.Uid})
      : super(key: key);
  final firstname;
  final username;
  final email;
  final Uid;
  @override
  State<FireStoreData> createState() => _FireStoreDataState();
}

class _FireStoreDataState extends State<FireStoreData> {
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  DocumentReference userd = FirebaseFirestore.instance
      .collection('user')
      .doc('K6LLf8Z8RoanhSljVLdwoAj8ZEj2');

  List<Map<String, dynamic>> users = [];

  Future<List<Map<String, dynamic>>> getUser() async {
    users = [];
    var data11 = await user.get();

    data11.docs.forEach((element) {
      users.add(element.data() as Map<String, dynamic>);
      print('DATA ${element.data()}');
    });
    print('LENGTH ${users.length}');
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.off(LoginFirestore());
          },
          child: Icon(Icons.logout),
        ),
        body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      snapshot.data!.length,
                      (index) => ListTile(
                        title: Row(
                          children: [
                            Text("${snapshot.data![index]['firstname']}"),
                            SizedBox(
                              width: 5,
                            ),
                            Text("${snapshot.data![index]['lastname']}"),
                          ],
                        ),
                        subtitle: Text("${snapshot.data![index]['email']}"),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
