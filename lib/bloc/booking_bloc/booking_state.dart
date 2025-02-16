part of 'booking_bloc.dart';

abstract class BookingState {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingAdded extends BookingState {}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object> get props => [message];
}

class GetBookingLoading extends BookingState {}
class GetBookingLoaded extends BookingState {
  final List<Booking> bookings;

  const GetBookingLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}
class GetBookingError extends BookingState {
  final String message;

  const GetBookingError(this.message);

  @override
  List<Object> get props => [message];
}
