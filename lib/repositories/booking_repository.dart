import 'dart:developer';

import 'package:hive/hive.dart';

import '../models/booking/booking.dart';

class BookingRepository {

  Future<Box<Booking>> get _box async => await Hive.openBox<Booking>("bookings");

  Future<void> addBooking(Booking booking) async {
    final box = await _box;
    await box.add(booking);
  }

  Future<List<Booking>> getBookings() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> removeBooking(String bookingId) async {
    final box = await _box;
    final index = box.values.toList().indexWhere((b) => b.id == bookingId);
    if (index != -1) await box.deleteAt(index);
  }
}