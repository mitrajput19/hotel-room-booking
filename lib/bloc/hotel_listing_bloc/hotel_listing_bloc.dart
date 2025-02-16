import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/hotel.dart';
import '../../repositories/hotel_repository.dart';

part 'hotel_listing_event.dart';
part 'hotel_listing_state.dart';

class HotelListingBloc extends Bloc<HotelListingEvent, HotelListingState> {
  final HotelRepository hotelRepository;
  List<Hotel> allHotels = [];

  HotelListingBloc({required this.hotelRepository}) : super(HotelListingInitial()) {
    on<LoadHotelsEvent>(_onLoadHotels);
    on<SearchHotelsEvent>(_onSearchHotels);
  }

  FutureOr<void> _onLoadHotels(
      LoadHotelsEvent event,
      Emitter<HotelListingState> emit,
      ) async {
    try {
      emit(HotelListingLoading());
      allHotels = await hotelRepository.getHotels();
      emit(HotelListingLoaded(allHotels));
    } catch (e) {
      emit(HotelListingError(e.toString()));
    }
  }

  Future<void> _onSearchHotels(
      SearchHotelsEvent event,
      Emitter<HotelListingState> emit,
      ) async {
    if (event.query.isEmpty) {
      emit(HotelListingLoaded(allHotels));
    } else {
      final results = allHotels
          .where((hotel) =>
          (hotel.name ?? "").toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(HotelSearchResults(results));
    }
  }

}