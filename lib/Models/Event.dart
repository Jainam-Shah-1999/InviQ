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
}
