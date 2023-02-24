import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DemoFireStore extends StatefulWidget {
  const DemoFireStore({Key? key}) : super(key: key);

  @override
  State<DemoFireStore> createState() => _DemoFireStoreState();
}

class _DemoFireStoreState extends State<DemoFireStore> {
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  DocumentReference userd =
      FirebaseFirestore.instance.collection('user').doc('s7koElBU1BkVJn32bqQm');

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
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // user.doc('CsHd9kFKONNDL8K4lNM6').delete();
            // user.doc('UaNQYhNw1IP7mNgU7iRI').update({'name': 'hello'});
            // user.doc('UaNQYhNw1IP7mNgU7iRI').set({'name': 'hello'});
          },
        ),
        body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    users.length,
                    (index) => ListTile(
                      title: Text("${users[index]['name']}"),
                      subtitle: Text("${users[index]['surname']}"),
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
