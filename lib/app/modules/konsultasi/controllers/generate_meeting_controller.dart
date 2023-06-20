import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/konsultasi/models/generate_meeting_model.dart';
import 'package:nuha/app/utility/calendar_client.dart';

class GenerateMeetingController extends GetxController {
  DateTime selectedDate = DateTime.now();
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(days: 1));
  // RxString meetLink = RxString('');
  // final CollectionReference mainCollection =
  //     FirebaseFirestore.instance.collection('event');
  // final DocumentReference documentReference =
  //     FirebaseFirestore.instance.collection('event').doc('test');

  // Future<void> storeEventData(GenerateMeeting eventInfo) async {
  //   DocumentReference documentReferencer =
  //       documentReference.collection('events').doc(eventInfo.id);

  //   Map<String, dynamic> data = eventInfo.toJson();

  //   print('DATA:\n$data');

  //   await documentReferencer.set(data).whenComplete(() {
  //     print("Event added to the database, id: {${eventInfo.id}}");
  //   }).catchError((e) => print(e));
  // }

  // Future<String?> createNewMeetLink() async {
  //   final apiKey =
  //       '904581381315-r5ukdkn5q021nd73infvp2fhkn6jdt75.apps.googleusercontent.com';
  //   final serviceAccountCredentials = auth.ServiceAccountCredentials.fromJson({
  //     'private_key': 'YOUR_PRIVATE_KEY',
  //     'client_email': 'YOUR_CLIENT_EMAIL',
  //   });

  //   final client = await auth.clientViaServiceAccount(
  //     serviceAccountCredentials,
  //     [calendar.CalendarApi.calendarScope],
  //   );

  //   final calendar = CalendarApi(client);

  //   final event = Event()
  //     ..summary = 'New Google Meet Event'
  //     ..start = EventDateTime()
  //     ..end = EventDateTime();

  //   event.start?.dateTime = DateTime.now();
  //   event.end?.dateTime = DateTime.now().add(Duration(hours: 1));

  //   final createdEvent = await calendar.events.insert(event, 'primary');

  //   final link = createdEvent.hangoutLink;
  //   return meetLink.value = link ?? 'No link available';
  // }
}
