part of 'hotel_listing_bloc.dart';

sealed class HotelListingState extends Equatable {
  const HotelListingState();

  @override
  List<Object> get props => [];
}

class HotelListingInitial extends HotelListingState {}

class HotelListingLoading extends HotelListingState {}



class HotelListingLoaded extends HotelListingState {
  final List<Hotel> hotels;

  const HotelListingLoaded(this.hotels);

  @override
  List<Object> get props => [hotels];
}

class HotelSearchResults extends HotelListingState {
  final List<Hotel> results;

  const HotelSearchResults(this.results);

  @override
  List<Object> get props => [results];
}

class HotelListingError extends HotelListingState {
  final String message;

  const HotelListingError(this.message);

  @override
  List<Object> get props => [message];
}