import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_room_booking/bloc/booking_bloc/booking_bloc.dart';
import 'package:hotel_room_booking/router/router.dart';

import 'bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import 'di/injection.dart';
import 'models/booking/booking.dart';
import 'models/hotel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  AppLifecycleListener(
    onDetach: () async {
      await Hive.close();
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return

      MultiBlocProvider(
          providers: [
          BlocProvider(
          create: (context) => HotelListingBloc(hotelRepository: getIt.get())),
            BlocProvider(
                create: (context) => BookingBloc(bookingRepository: getIt.get()))
    ],
    child: MaterialApp.router(
    title: 'Hotel Booking',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2853af)),
    useMaterial3: true,
    ),
    routerConfig: router,
    ),
    );

  }
}
