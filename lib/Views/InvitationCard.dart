import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class InvitationCard extends StatefulWidget {
  final String guestDocumentId;
  final String eventDocumentId;
  final FirebaseUser user;
  InvitationCard(this.guestDocumentId, this.eventDocumentId, this.user);
  @override
  _InvitationCardState createState() =>
      _InvitationCardState(guestDocumentId, eventDocumentId, user);
}

class _InvitationCardState extends State<InvitationCard> {
  final String guestDocumentId;
  final String eventDocumentId;
  final FirebaseUser user;
  bool isStartDateUpdated = false;
  DateTime selectedStartDate = DateTime.now();
  bool isEndDateUpdated = false;
  DateTime selectedEndDate = DateTime.now();
  bool isStartTimeUpdated = false;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  bool isEndTimeUpdated = false;
  TimeOfDay selectedEndTime = TimeOfDay.now();
  final event =
      new Event(null, null, null, null, null, null, null, null, null, null);
  _InvitationCardState(this.guestDocumentId, this.eventDocumentId, this.user);
  @override
  Widget build(BuildContext context) {
    final eventDocumentReference = Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .document(eventDocumentId);
    final guestDocumentReference = Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .document(eventDocumentId)
        .collection('guest')
        .document(guestDocumentId);
    TextEditingController eventName = new TextEditingController();
    TextEditingController eventType = new TextEditingController();
    TextEditingController eventStartDate = new TextEditingController();
    TextEditingController eventStartTime = new TextEditingController();
    TextEditingController eventEndDate = new TextEditingController();
    TextEditingController eventEndTime = new TextEditingController();
    TextEditingController eventLocation = new TextEditingController();
    TextEditingController guestName = new TextEditingController();
    TextEditingController invitationType = new TextEditingController();
    ScreenshotController _screenshotController = new ScreenshotController();
    eventDocumentReference.get().then((eventDatasnapshot) {
      if (eventDatasnapshot.exists) {
        print('event Found!');
        var starttime = eventDatasnapshot.data['eventStartTime']
            .toString()
            .substring(10, 15);
        var endtime =
            eventDatasnapshot.data['eventEndTime'].toString().substring(10, 15);

        if (!isStartDateUpdated) {
          selectedStartDate =
              DateTime.parse(eventDatasnapshot.data['eventStartDate']);
        }
        if (!isStartTimeUpdated) {
          selectedStartTime = TimeOfDay(
              hour: int.parse(starttime.split(':')[0]),
              minute: int.parse(starttime.split(':')[1]));
        }
        if (!isEndDateUpdated) {
          selectedEndDate =
              DateTime.parse(eventDatasnapshot.data['eventEndDate']);
        }
        if (!isEndTimeUpdated) {
          selectedEndTime = TimeOfDay(
              hour: int.parse(endtime.split(':')[0]),
              minute: int.parse(endtime.split(':')[1]));
        }
        var selectedstartdate = selectedStartDate.toString().substring(0, 10);
        var selectedstarttime = selectedStartTime.toString().substring(10, 15);
        var selectedenddate = selectedEndDate.toString().substring(0, 10);
        var selectedendtime = selectedEndTime.toString().substring(10, 15);

        eventName.text = eventDatasnapshot.data['eventName'];
        eventType.text = eventDatasnapshot.data['eventType'];
        eventStartDate.text = selectedstartdate;
        eventStartTime.text = selectedstarttime;
        eventEndDate.text = selectedenddate;
        eventEndTime.text = selectedendtime;
        eventLocation.text = eventDatasnapshot.data['eventLocation'];
        invitationType.text = eventDatasnapshot.data['invitationType'];
      }
    });
    guestDocumentReference.get().then((guestDatasnapshot) {
      if (guestDatasnapshot.exists) {
        print('guest Found!');
        guestName.text = guestDatasnapshot.data['guestName'];
      }
    });
    Map<String, String> data = <String, String>{
      "eventId": eventDocumentId,
      "guestId": guestDocumentId,
    };

    void _takeScreenshot() async {
      final filePath = (await getExternalStorageDirectory()).path;
      final imageFile = await _screenshotController.capture();
      File card = new File('$filePath/screenshot.png');
      card.writeAsBytes(imageFile);
      Share.shareFiles([card.path]);
      Navigator.of(context).pop();
    }

    return Scaffold(
        appBar: new AppBar(
          title: new Text('Invitation Card'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0,
            ),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Screenshot(
                  controller: _screenshotController,
                  child: Card(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('You Are Invited!',
                            style: TextStyle(fontSize: 30.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Guest Name:',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          controller: guestName,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Event Name:',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(360.0)),
                          ),
                          controller: eventName,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Event Type',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          controller: eventType,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Flexible(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Event Start Date',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                controller: eventStartDate,
                              ),
                            ),
                            new Flexible(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Event start time',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                controller: eventStartTime,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            new Flexible(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Event End Date',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                controller: eventEndDate,
                              ),
                            ),
                            new Flexible(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Event End time',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                controller: eventEndTime,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Event Place',
                            hintText: '440 Banquets',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          controller: eventLocation,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: QrImage(
                            data: data.toString(),
                            size: 150.0,
                          )),
                    ]),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _takeScreenshot();
                },
                child: Text("Share Invitation card"),
              ),
            ])));
  }
}
