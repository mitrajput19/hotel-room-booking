import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_room_booking/bloc/booking_bloc/booking_bloc.dart';
import 'package:hotel_room_booking/models/booking/booking.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import '../../models/hotel.dart';
import '../../router/router.dart';
import 'booking_hotel_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<BookingBloc>(context).add(GetBooking());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            router.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "My Booking",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
        if (state is GetBookingLoading) {
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context,index){
                return Shimmer.fromColors(
                    baseColor: const Color(0xFFEBEBF4),
                    highlightColor: const Color(0xFFF4F4F4),
                    child: BookingHotelCard(hotel: Booking(hotel: Hotel.fromJson({"main_image":"https://images.pexels.com/photos/27650603/pexels-photo-27650603.jpeg"})),));
              }, separatorBuilder: (context,index){
            return const SizedBox(height: 10,);
          }, itemCount: 2);
        }

        if(state is GetBookingLoaded){
          return state.bookings.isEmpty ? const Center(child: Text("Please add hotels!"),):ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BookingHotelCard(hotel: state.bookings[index],);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: state.bookings.length);
        }
        else if (state is GetBookingError) {
          return Center(child: Text("No Data Found, Please back later!",style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w700),));
        }
        return const SizedBox();
      }),
    );
  }
}
