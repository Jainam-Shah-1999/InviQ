import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateEventPage extends StatefulWidget {
  final FirebaseUser user;
  final String documentId;
  final Event event;
  UpdateEventPage({Key key, @required this.event, this.user, this.documentId});
  @override
  _UpdateEventPageState createState() => _UpdateEventPageState(
      key: key, event: event, user: user, documentId: documentId);
}

class _UpdateEventPageState extends State<UpdateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseUser user;
  final String documentId;
  final Event event;
  _UpdateEventPageState(
      {Key key, @required this.event, this.user, this.documentId});

  //datetime declaration
  DateTime minDate = DateTime.now();
  bool isStartDateUpdated = false;
  DateTime selectedStartDate = DateTime.now();
  bool isEndDateUpdated = false;
  DateTime selectedEndDate = DateTime.now();
  bool isStartTimeUpdated = false;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  bool isEndTimeUpdated = false;
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime startDatepicked = await showDatePicker(
        context: context,
        initialDate: minDate,
        firstDate: minDate,
        lastDate: DateTime(2100));
    if (startDatepicked != null && startDatepicked != selectedStartDate) {
      isStartDateUpdated = true;
      setState(() {
        selectedStartDate = startDatepicked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay pickedStartTime = await showTimePicker(
        context: context,
        initialTime: selectedStartTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedStartTime != null && pickedStartTime != selectedStartTime) {
      isStartTimeUpdated = true;
      setState(() {
        selectedStartTime = pickedStartTime;
      });
    }
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime endDatepicked = await showDatePicker(
        context: context,
        initialDate: minDate,
        firstDate: minDate,
        lastDate: DateTime(2100));
    if (endDatepicked != null && endDatepicked != selectedEndDate) {
      isEndDateUpdated = true;
      setState(() {
        selectedEndDate = endDatepicked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay pickedEndTime = await showTimePicker(
        context: context,
        initialTime: selectedEndTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedEndTime != null && pickedEndTime != selectedEndTime) {
      isEndTimeUpdated = true;
      setState(() {
        selectedEndTime = pickedEndTime;
      });
    }
  }

// DD Menu for event type
  String eventTypeValue = "BirthDay";

  @override
  Widget build(BuildContext context) {
    final documentReference = Firestore.instance
        .collection('InviQ')
        .document(user.email)
        .collection('event')
        .document(documentId);
    TextEditingController eventName = new TextEditingController();
    TextEditingController eventStartDate = new TextEditingController();
    TextEditingController eventStartTime = new TextEditingController();
    TextEditingController eventEndDate = new TextEditingController();
    TextEditingController eventEndTime = new TextEditingController();
    TextEditingController eventLocation = new TextEditingController();
    TextEditingController numberOfGuests = new TextEditingController();
    TextEditingController invitationType = new TextEditingController();
    TextEditingController notes = new TextEditingController();

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        var starttime =
            datasnapshot.data['eventStartTime'].toString().substring(10, 15);
        var endtime =
            datasnapshot.data['eventEndTime'].toString().substring(10, 15);

        if (!isStartDateUpdated) {
          selectedStartDate =
              DateTime.parse(datasnapshot.data['eventStartDate']);
        }
        if (!isStartTimeUpdated) {
          selectedStartTime = TimeOfDay(
              hour: int.parse(starttime.split(':')[0]),
              minute: int.parse(starttime.split(':')[1]));
        }
        if (!isEndDateUpdated) {
          selectedEndDate = DateTime.parse(datasnapshot.data['eventEndDate']);
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
        if (eventTypeValue != datasnapshot.data['eventType']) {
          setState(() {
            eventTypeValue = datasnapshot.data['eventType'];
          });
        }
        eventName.text = datasnapshot.data['eventName'];
        eventStartDate.text = selectedstartdate;
        eventStartTime.text = selectedstarttime;
        eventEndDate.text = selectedenddate;
        eventEndTime.text = selectedendtime;
        eventLocation.text = datasnapshot.data['eventLocation'];
        numberOfGuests.text = datasnapshot.data['numberOfGuests'];
        invitationType.text = datasnapshot.data['invitationType'];
        notes.text = datasnapshot.data['notes'];
      }
    });
    void _submitForm() {
      if (_formKey.currentState.validate()) {
        Map<String, String> data = <String, String>{
          "eventName": eventName.text,
          "eventType": eventTypeValue,
          "eventStartDate": selectedStartDate.toString(),
          "eventStartTime": selectedStartTime.toString(),
          "eventEndDate": selectedEndDate.toString(),
          "eventEndTime": selectedEndTime.toString(),
          "eventLocation": eventLocation.text,
          "numberOfGuests": numberOfGuests.text,
          "invitationType": invitationType.text,
          "notes": notes.text,
        };
        try {
          documentReference.setData(data).whenComplete(() {
            print("document Updated!");
            Navigator.of(context).pop();
          });
        } on Exception {
          print(Exception);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Event'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event Name cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      hintText: 'Eg. Birthday Party of John',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: eventName,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: eventTypeValue,
                      onChanged: (String newValue) {
                        setState(() {
                          eventTypeValue = newValue;
                        });
                      },
                      items: <String>["BirthDay", "Wedding", "Party"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Event Type',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: TextFormField(
                          readOnly: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Event start date cannot be empty';
                            }
                            return null;
                          },
                          onTap: () => _selectStartDate(context),
                          decoration: InputDecoration(
                            labelText: 'Event Start Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          controller: eventStartDate,
                        ),
                      ),
                      new Flexible(
                        child: TextFormField(
                          readOnly: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Event start time cannot be empty';
                            }
                            return null;
                          },
                          onTap: () => _selectStartTime(context),
                          decoration: InputDecoration(
                            labelText: 'Event start time',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
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
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Event end date cannot be empty';
                            }
                            return null;
                          },
                          onTap: () => _selectEndDate(context),
                          decoration: InputDecoration(
                            labelText: 'Event End Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          controller: eventEndDate,
                        ),
                      ),
                      new Flexible(
                        child: TextFormField(
                          readOnly: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Event end time cannot be empty';
                            }
                            return null;
                          },
                          onTap: () => _selectEndTime(context),
                          decoration: InputDecoration(
                            labelText: 'Event End time',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
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
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Event Place cannot be empty';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Number of guests cannot be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Number of Guests',
                      hintText: '10, 20, 30 ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: numberOfGuests,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Invitation Type Cannot be Empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Invitation Type',
                      hintText: 'Personal Invite or Registration Link',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: invitationType,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Notes (Optional)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    controller: notes,
                  ),
                ),
                new ElevatedButton(
                  onPressed: _submitForm,
                  child: new Text("Update"),
                ),
              ],
            )),
      ),
    );
  }
}
