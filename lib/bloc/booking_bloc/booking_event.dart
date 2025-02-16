part of 'booking_bloc.dart';

abstract class BookingEvent {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class AddBooking extends BookingEvent {
  final Booking booking;

  const AddBooking(this.booking);

  @override
  List<Object> get props => [booking];
}

class GetBooking extends BookingEvent {
}

class RemoveBooking extends BookingEvent {
  final Booking booking;

  const RemoveBooking(this.booking);

  @override
  List<Object> get props => [booking];
}