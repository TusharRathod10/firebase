import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class StreamFirebase extends StatefulWidget {
  const StreamFirebase({Key? key}) : super(key: key);

  @override
  State<StreamFirebase> createState() => _StreamFirebaseState();
}

class _StreamFirebaseState extends State<StreamFirebase> {
  CollectionReference chat = FirebaseFirestore.instance.collection('chat');
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
  final global = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Form(
        key: global,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextFormField(
                  onChanged: (value) {},
                  controller: chatting,
                  decoration: InputDecoration(
                      hintText: "Message",
                      suffixIcon: Icon(Icons.camera_alt),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              chatting.text == ""
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () {
                        if (global.currentState!.validate()) {
                          chat.add({
                            "msg": "${chatting.text}",
                            "id": "${box.read('userid')}",
                            "time": "${DateTime.now()}"
                          });
                          chatting.clear();
                        } else {
                          print("No Data Available");
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade200,
        child: StreamBuilder<QuerySnapshot>(
          stream: chat.orderBy('time').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                    return Align(
                      alignment: data['id'] == box.read('userid')
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: data['id'] == box.read('userid')
                                ? Colors.green
                                : Colors.yellow,
                            borderRadius: data['id'] == box.read('userid')
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                        child: Column(
                          crossAxisAlignment: data['id'] == box.read('userid')
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data['msg']}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${formate.format(DateTime.parse(data['time']))}',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('NO Data'));
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
