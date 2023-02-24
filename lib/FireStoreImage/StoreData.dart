import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/FireStoreImage/LoginFirestoreImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class StreamFirebaseImg extends StatefulWidget {
  const StreamFirebaseImg({Key? key}) : super(key: key);

  @override
  State<StreamFirebaseImg> createState() => _StreamFirebaseImgState();
}

class _StreamFirebaseImgState extends State<StreamFirebaseImg> {
  CollectionReference chat = FirebaseFirestore.instance.collection('chat2');
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  final box = GetStorage();

  // @override
  // void initState() {
  //   userd = FirebaseFirestore.instance
  //       .collection('user')
  //       .doc('${box.read('userid')}');
  //
  //   // TODO: implement initState
  //   super.initState();
  // }

  var formate = DateFormat('hh:mm a');

  TextEditingController chatting = TextEditingController();
  late List<Map<String, dynamic>> DATA;

  final global = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              box.remove('userid');
              Get.offAll(LoginFirestoreImg());
            },
            child: Icon(Icons.logout)),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: chat.orderBy('time').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                      if (snapshot.hasData) {
                        // DATA = snapshot.data! as List<Map<String, dynamic>>;
                        // DATA.forEach((element) {
                        //   if (element['id'] == GetStorage().read('id')) {}
                        // });
                        if (snapshot.data!.docs.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                              return Column(
                                crossAxisAlignment:
                                    data['id'] == box.read('userid')
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: data['id'] == box.read('userid')
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color:
                                              data['id'] == box.read('userid')
                                                  ? Colors.green
                                                  : Colors.yellow,
                                          borderRadius: data['id'] ==
                                                  box.read('userid')
                                              ? BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                )
                                              : BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                )),
                                      child: Column(
                                        crossAxisAlignment:
                                            data['id'] == box.read('userid')
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data['msg']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${formate.format(DateTime.parse(data['time']))}',
                                            style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${data['profile']}"),
                                              // image: NetworkImage(data['id'] ==
                                              //         box.read('userid')
                                              //     ? "https://play-lh.googleusercontent.com/CKHLf6wwlacMnjuG730pY4cwJbUMoHDtFfoeVKuOxRmPwGXGkzzBfvB9jCJjBqhMSic"
                                              //     : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3WEmfJCME77ZGymWrlJkXRv5bWg9QQmQEzw&usqp=CAU"),

                                              fit: BoxFit.cover),
                                          border: Border.all(
                                            width: 0.6,
                                            color: Colors.black,
                                          ),
                                          // color:
                                          //     data['id'] == box.read('userid')
                                          //         ? Colors.green
                                          //         : Colors.yellow,
                                          shape: BoxShape.circle),
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return Text('NO Data');
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Form(
              key: global,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onChanged: (value) => setState(() {}),
                        controller: chatting,
                        decoration: InputDecoration(
                            hintText: "Message",
                            suffixIcon: Icon(Icons.camera_alt),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ),
                    chatting.text.toString() == ''
                        ? SizedBox()
                        : IconButton(
                            onPressed: () async {
                              if (global.currentState!.validate()) {
                                var data22 = await user
                                    .doc('${box.read('userid')}')
                                    .get();

                                var currentUserData =
                                    data22.data() as Map<String, dynamic>;

                                chat.add({
                                  "msg": "${chatting.text}",
                                  "id": "${box.read('userid')}",
                                  "time": "${DateTime.now()}",
                                  "profile": "${currentUserData['profile']}"
                                });
                                chatting.text = "";
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
