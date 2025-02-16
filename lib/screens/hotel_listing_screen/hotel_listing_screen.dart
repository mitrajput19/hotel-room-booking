import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_room_booking/bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import 'package:hotel_room_booking/screens/hotel_listing_screen/hotel_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/hotel.dart';
import 'hotel_search_delegate.dart';

class HotelListingScreen extends StatefulWidget {
  const HotelListingScreen({super.key});

  @override
  State<HotelListingScreen> createState() => _HotelListingScreenState();
}

class _HotelListingScreenState extends State<HotelListingScreen> {
  String search = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotelListingBloc>(context).add(LoadHotelsEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hotelz",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.fileLines),
            onPressed: () {
              context.push("/booking");
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: RefreshIndicator(
          onRefresh: () async {
             BlocProvider.of<HotelListingBloc>(context).add(LoadHotelsEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFe9ebed),
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            onTap: (){
                              showSearch(
                                context: context,
                                delegate: HotelSearchDelegate(
                                  hotelBloc: context.read<HotelListingBloc>(),
                                ),
                              );
                            },
                            decoration: const InputDecoration(
                                hintText: "Search...", border: InputBorder.none),
                          ),
                        ),
                        const Icon(Icons.filter_list_outlined)
                      ],
                    ),
                  ),
                ),


                const SizedBox(height: 20,),
                BlocBuilder<HotelListingBloc, HotelListingState>(builder: (context,state){
                  if (state is HotelListingLoading) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Shimmer.fromColors(
                              baseColor: const Color(0xFFEBEBF4),
                              highlightColor: const Color(0xFFF4F4F4),
                              child: HotelCard(hotel: Hotel.fromJson({"main_image":"https://images.pexels.com/photos/27650603/pexels-photo-27650603.jpeg"}),));
                        }, separatorBuilder: (context,index){
                      return const SizedBox(height: 10,);
                    }, itemCount: 2);
                  }
                  if(state is HotelListingLoaded){
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),

                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          final hotel = state.hotels[index];
                          return HotelCard(hotel: hotel,);
                        }, separatorBuilder: (context,index){
                      return const SizedBox(height: 10,);
                    }, itemCount: state.hotels.length);
                  }
                  else if (state is HotelListingError) {
                    return Center(child: Text("No Data Found, Please back later!",style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700),));
                  }
                  return const SizedBox();
                }),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
