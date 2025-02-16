import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_room_booking/router/router.dart';

import '../../models/hotel.dart';

class HotelCard extends StatefulWidget {
  final Hotel hotel;
  const HotelCard({super.key,required this.hotel});

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push('/details/${widget.hotel}');

      },
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:  BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.contain,
                  imageUrl: widget.hotel.mainImage ?? "",
                  errorWidget: (context,str,value){
                    return SizedBox();
                  },
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  child:  Icon(
                    isFavourite ? Icons.favorite:Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration:BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 20,
                        color: Color(0xFFf4c700),
                      ),
                      const SizedBox(width: 4,),
                      Text('${widget.hotel.rating ?? ""}',style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.hotel.name ?? "",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600,fontSize: 18),),
                    Text(
                      '${widget.hotel.location?.city ?? ""} ${widget.hotel.location?.address ?? ""}',style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xFFa5a5a5)),),
                    Row(
                      children: [
                        Icon(Icons.bed,color: Colors.black45,size: 18,),
                        SizedBox(width: 2,),
                        Text("${widget.hotel.availableRooms} rooms",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black45),),
                      ],
                    ),
                    Text("Types: ${(widget.hotel.roomTypes ?? []).map((e) => e.type ?? "").toList().join(",")}",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black45),)
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$${(widget.hotel.pricePerNight ?? 0).toStringAsFixed(2)}",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xFF2853af)),),
                  Text("Per Night",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFFa5a5a5)),),

                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
