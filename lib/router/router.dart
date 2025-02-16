import 'package:go_router/go_router.dart';

import '../screens/hotel_detail_screen/hotel_detail_screen.dart';
import '../screens/hotel_listing_screen/hotel_listing_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HotelListingScreen(),
    ),
    GoRoute(
      path: '/details/:hotelId',
      builder: (context, state) => HotelDetailScreen(
        hotelId: state.pathParameters['hotelId'],
      ),
    ),
    // GoRoute(
    //   path: '/cart',
    //   builder: (context, state) => const CartScreen(),
    // ),
  ],
);