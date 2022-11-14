import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notifiy extends StatefulWidget {
  const Notifiy({Key? key}) : super(key: key);

  @override
  State<Notifiy> createState() => _NotifiyState();
}

class _NotifiyState extends State<Notifiy> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration myBoxDecoration() {
      return BoxDecoration(
        color: Colors.white70,
        border: Border.all(width: 3.0),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFb1c4d2),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("accept")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('accepted')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      decoration: myBoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Accepted By: ${_documentSnapshot['accept-by']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Pic Up Location: ${_documentSnapshot['pic-up-loc']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Drop Off Loc:  ${_documentSnapshot['drop-off-loc']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      )), //Display a list // Add a FutureBuilder
    );
  }
}
