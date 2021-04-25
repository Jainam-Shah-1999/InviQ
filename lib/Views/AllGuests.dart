import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:flutter_application_1/Views/AddGuest.dart';

//widgets
import 'package:flutter_application_1/Widgets/EventListCard_widget.dart';

class AllGuests extends StatefulWidget {
  final FirebaseUser user;
  final String documentId;
  AllGuests({Key key, this.user, this.documentId});
  @override
  _AllGuestsState createState() =>
      _AllGuestsState(key: key, user: user, documentId: documentId);
}

class _AllGuestsState extends State<AllGuests> {
  final FirebaseUser user;
  final String documentId;
  _AllGuestsState({Key key, this.user, this.documentId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('All Guests'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            new Expanded(
              child: StreamBuilder(
                  stream: getGuestsnapshot(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    return new ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildAllGuestsCard(
                                context, snapshot.data.documents[index]));
                  }),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new AddGuest(user, documentId)));
          },
          child: Icon(Icons.add),
        ));
  }

  Stream<QuerySnapshot> getGuestsnapshot(BuildContext context) async* {
    yield* Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .document(documentId)
        .collection('guest')
        .orderBy('guestName')
        .snapshots();
  }
}
