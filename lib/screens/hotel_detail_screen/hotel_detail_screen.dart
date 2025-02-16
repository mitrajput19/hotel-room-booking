
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_room_booking/bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import 'package:hotel_room_booking/router/router.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking_bloc/booking_bloc.dart';
import '../../models/booking/booking.dart';
import '../../models/hotel.dart';

class HotelDetailScreen extends StatefulWidget {
  final dynamic hotelId;
  const HotelDetailScreen({super.key, required this.hotelId});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {

  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now().add(const Duration(days: 1));
  int room = 1;
  int guest = 1;
  Hotel? hotel;

  @override
  void initState() {
    super.initState();
    _loadHotelDetails();
  }

  void _loadHotelDetails() async {
    hotel =  (context.read<HotelListingBloc>().allHotels ?? []).firstWhere((element) => element.id.toString() == widget.hotelId.toString());

    setState(() {});
  }

  double _calculateTotal() {
    if (hotel == null) return 0.0;
    final days = checkOut.difference(checkIn).inDays;
    return ((hotel?.pricePerNight ?? 0) * days * room) + 10;
  }


  double _calculatePriceWithoutCharges() {
    if (hotel == null) return 0.0;
    final days = checkOut.difference(checkIn).inDays;
    return ((hotel?.pricePerNight ?? 0) * days * room);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to cart successfully!')),
          );
          Navigator.pop(context);
        }
        if (state is BookingError) {
          log(state.message,name: "Error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
  child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            router.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Request to book",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                       checkIn = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate:  DateTime.now().add(const Duration(minutes: 1)),
                        lastDate:
                            DateTime(2030),
                      ) ?? DateTime.now();
                       setState(() {

                       });

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf7f7f7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.calendar_month),
                              Text(
                                "Check - In",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            DateFormat.yMMMMd('en_US').format(checkIn),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      checkOut = await showDatePicker(
                        context: context,
                        firstDate: checkIn.add(const Duration(days: 1)),
                        initialDate:  checkIn.add(const Duration(days: 1)),
                        lastDate:
                        DateTime(2030),
                      ) ?? checkIn.add(const Duration(days: 1));
                      setState(() {

                      });

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf7f7f7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.calendar_month),
                              Text(
                                "Check - Out",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            DateFormat.yMMMMd('en_US').format(checkOut),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rooms",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(room>1){
                          setState(() {
                            --room;
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFecf1f6),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Color(0xFF6b89c7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$room",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(room<5){
                          setState(() {
                            ++room;
                          });
                        }

                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2853af),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Guest",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(guest>1){
                          setState(() {
                            guest--;
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFecf1f6),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Color(0xFF6b89c7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$guest",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(guest<10){
                          setState(() {
                            guest++;
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2853af),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Payment Details",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total : ${checkOut.difference(checkIn).inDays} Night",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  "\$${_calculatePriceWithoutCharges().toStringAsFixed(2)}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cleaning Fee",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  "\$5",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Service Fee",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  "\$5",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Color(0xFFe7e7e8),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payment:",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "\$${_calculateTotal().toStringAsFixed(2)}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: () {
                  if (hotel == null) return;

                  final booking = Booking(
                    id: hotel?.id,
                    hotel: hotel!,
                    checkIn: checkIn,
                    checkOut: checkOut,
                    rooms: room,
                    guests: guest,
                    totalPrice: _calculateTotal(),
                  );
                  for(var i in context.read<BookingBloc>().bookings){
                    if(i.hotel?.id == hotel?.id) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Already in cart')),
                      );
                        return;
                      }
                    }


                  context.read<BookingBloc>().add(AddBooking(booking));
                },
                height: 50,
                minWidth: 80,
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                disabledElevation: 0,
                hoverElevation: 0,
                color: const Color(0xFF2853af),
                disabledColor: Theme.of(context).disabledColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Builder(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 10),
                        child: Text(
                          "Checkout",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w700,color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
);
  }
}
