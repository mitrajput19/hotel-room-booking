import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_room_booking/models/booking/booking.dart';
import 'package:hotel_room_booking/router/router.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking_bloc/booking_bloc.dart';
import '../../models/hotel.dart';

class BookingHotelCard extends StatefulWidget {
  final Booking hotel;
  const BookingHotelCard({super.key, required this.hotel});

  @override
  State<BookingHotelCard> createState() => _BookingHotelCardState();
}

class _BookingHotelCardState extends State<BookingHotelCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        context.read<BookingBloc>().add(RemoveBooking(widget.hotel));
        BlocProvider.of<BookingBloc>(context).add(GetBooking());
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFe9ebed))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                width: 90,
                height: 170,
                fit: BoxFit.cover,
                imageUrl:
                    widget.hotel.hotel?.mainImage ?? "",
                errorWidget: (context, str, value) {
                  return SizedBox();
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.hotel.hotel?.name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        
                        ),
                      ),
                      Wrap(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Color(0xFFf4c700),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '${widget.hotel.hotel?.rating ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold,fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF9ea6ac),
                        size: 14,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                            '${widget.hotel.hotel?.location?.city ?? ""} ${widget.hotel.hotel?.location?.address ?? ""}',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Color(
                                  0xFF9ea6ac,
                                ),
                            fontSize: 11
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(text: TextSpan(
                    text: "\$${widget.hotel.hotel?.pricePerNight ?? 0}",style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700,color: Color(0xFF2e58b1)),
                    children: [
                      TextSpan(
                        text: " /night",style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ]
                  ),),
                  SizedBox(height: 10,),
                  Divider(color: Color(0xFFe9ebed),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month,color: Color(0xFF78828a),size: 18,),
                          SizedBox(width: 2,),
                          Text("Dates",style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 14),),
                        ],
                      ),
                      Text("${widget.hotel.checkIn?.day ?? 0}-${widget.hotel.checkOut?.day ?? 0} ${DateFormat.MMM().format(widget.hotel.checkOut!)} ${widget.hotel.checkOut?.year ?? 0}",style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700,fontSize: 12),),
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person,color: Color(0xFF78828a),size: 18,),
                          SizedBox(width: 2,),
                          Text("Guest",style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 14)),
                        ],
                      ),
                      Text("${widget.hotel.guests ?? 0} Guests (${widget.hotel.rooms ?? 0} Room)",style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 12,fontWeight: FontWeight.w700),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
