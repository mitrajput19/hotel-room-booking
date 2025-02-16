import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_room_booking/screens/hotel_listing_screen/hotel_card.dart';

import '../../bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import '../../models/hotel.dart';

class HotelSearchDelegate extends SearchDelegate<String> {
  final HotelListingBloc hotelBloc;

  HotelSearchDelegate({required this.hotelBloc});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        BlocProvider.of<HotelListingBloc>(context).add(LoadHotelsEvent());

        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    hotelBloc.add(SearchHotelsEvent(query));
    return BlocBuilder<HotelListingBloc, HotelListingState>(
      bloc: hotelBloc,
      builder: (context, state) {
        if (state is HotelSearchResults) {
          return HotelList(hotels: state.results);
        }
        return const Center(child: Text('No results found'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class HotelList extends StatelessWidget {
  final List<Hotel> hotels;

  const HotelList({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0),
          child: HotelCard(hotel: hotel),
        );
      },
    );
  }
}