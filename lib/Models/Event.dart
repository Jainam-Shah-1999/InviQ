class Event {
  String eventName;
  String eventType;
  DateTime eventStartDate;
  DateTime eventEndDate;
  String eventLocation;
  String numberOfGuests;
  String invitationType;
  String notes;

  Event(
    this.eventName,
    this.eventType,
    this.eventStartDate,
    this.eventEndDate,
    this.eventLocation,
    this.numberOfGuests,
    this.invitationType,
    this.notes,
  );
}
