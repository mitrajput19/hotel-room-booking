import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../models/booking/booking.dart';
import '../../repositories/booking_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;
  List<Booking> bookings = [];

  BookingBloc({required this.bookingRepository}) : super(BookingInitial()) {
    on<AddBooking>(_onAddBooking);
    on<RemoveBooking>(_onRemoveBooking);
    on<GetBooking>(_getBooking);
  }

  Future<void> _onAddBooking(AddBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      await bookingRepository.addBooking(event.booking);
      emit(BookingAdded());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onRemoveBooking(RemoveBooking event, Emitter<BookingState> emit) async {

    try {
      await bookingRepository.removeBooking(event.booking.id ?? "");

    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }


  Future<void> _getBooking(GetBooking event, Emitter<BookingState> emit) async {
    emit(GetBookingLoading());
    try {
       bookings = await bookingRepository.getBookings();
      emit(GetBookingLoaded(bookings));
    } catch (e) {
      emit(GetBookingError(e.toString()));
    }
  }

}
