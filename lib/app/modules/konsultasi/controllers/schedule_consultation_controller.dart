import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/modules/konsultasi/models/consultant_model.dart';
import 'package:nuha/app/modules/konsultasi/models/schedule_consultation_model.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleConsultationController extends GetxController {
  String? consultantId;
  RxList<ScheduleConsultation> schedules = <ScheduleConsultation>[].obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> focusedDate = Rx<DateTime>(DateTime.now());
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  RxList<String> availableDays = <String>[].obs;
  RxList<Consultant> consultants = <Consultant>[].obs;
  Rx<DateTime> dateTimeBooked = Rx<DateTime>(DateTime.now());
  RxBool isScheduleSelected = false.obs;

  ScheduleConsultationController({required this.consultantId});

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
    fetchAvailableDays();
    fetchSchedule(selectedDate.value);
  }

  String getDayName(DateTime dateTime) {
    final daysName = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    return daysName[dateTime.weekday];
  }

  Future<void> fetchAvailableDays() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('consultant')
          .doc(consultantId)
          .collection('consultant_schedule')
          .get();
      final List<String> days = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['day'] as String;
      }).toList();
      availableDays.value = days;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchSchedule(DateTime selectedDate) async {
    final String selectedDay = getDayName(selectedDate);
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('consultant')
          .doc(consultantId)
          .collection('consultant_schedule')
          .where('day', isEqualTo: selectedDay)
          .get();

      schedules.value = snapshot.docs
          .map((doc) => ScheduleConsultation.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  void onDateSelected(DateTime date, DateTime focused) {
    final selectedDayName = DateFormat('EEEE', 'id_ID').format(date);

    if (availableDays.contains(selectedDayName)) {
      selectedDate.value = date;
      focusedDate.value = focused;
      fetchSchedule(date);
    }
  }

  void onCalendarFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
  }

  void onCalendarPageChanged(DateTime focused) {
    focusedDate.value = focused;
  }

  int getDaysInTwoMonths(DateTime date) {
    int currentYear = date.year;
    int currentMonth = date.month;
    int nextMonth = currentMonth + 1;
    int nextYear = currentYear;

    if (nextMonth > 12) {
      nextMonth -= 12;
      nextYear++;
    }

    int daysInNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;

    return (DateTime(nextYear, nextMonth, 0)
            .difference(DateTime(currentYear, currentMonth, 1))
            .inDays) +
        daysInNextMonth;
  }

  double maxRowHeight(int maxRows) {
    double dayPickerHeight = 60;
    double rowSpacing = 8;

    return (dayPickerHeight + maxRows) + (rowSpacing * (maxRows - 1));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getConsultant(
      consultantId) async {
    return FirebaseFirestore.instance
        .collection('consultant')
        .doc(consultantId)
        .get();
  }

  TimeOfDay timeConvert(String time) {
    List<String> split = time.split(':');
    int hour = int.parse(split[0]);
    int minute = int.parse(split[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }
}
