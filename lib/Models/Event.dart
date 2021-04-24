import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  String eventName;
  String eventType;
  DateTime eventStartDate;
  TimeOfDay eventStartTime;
  DateTime eventEndDate;
  TimeOfDay eventEndTime;
  String eventLocation;
  String numberOfGuests;
  String invitationType;
  String notes;

  Event(
    this.eventName,
    this.eventType,
    this.eventStartDate,
    this.eventStartTime,
    this.eventEndDate,
    this.eventEndTime,
    this.eventLocation,
    this.numberOfGuests,
    this.invitationType,
    this.notes,
  );

  Event.fromSnapshot(DocumentSnapshot snapshot)
      : eventName = snapshot['eventName'],
        eventType = snapshot['eventType'],
        eventStartDate = DateTime.parse(snapshot['eventStartDate']),
        eventStartTime = TimeOfDay(hour:13, minute:08),
        eventEndDate = DateTime.parse(snapshot['eventEndDate']),
        eventEndTime = TimeOfDay(hour:13, minute:08),
        eventLocation = snapshot['eventLocation'],
        numberOfGuests = snapshot['numberOfGuests'],
        invitationType = snapshot['invitationType'],
        notes = snapshot['notes'];
}
