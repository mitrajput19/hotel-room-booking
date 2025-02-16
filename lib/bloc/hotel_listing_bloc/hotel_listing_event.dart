part of 'hotel_listing_bloc.dart';

abstract class HotelListingEvent extends Equatable {
  const HotelListingEvent();

  @override
  List<Object> get props => [];
}

class GetHotels extends HotelListingEvent{}
class LoadHotelsEvent extends HotelListingEvent {}

class RefreshHotelsEvent extends HotelListingEvent {}

class SearchHotelsEvent extends HotelListingEvent {
  final String query;

  const SearchHotelsEvent(this.query);

  @override
  List<Object> get props => [query];
}