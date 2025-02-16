import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hotel_room_booking/bloc/booking_bloc/booking_bloc.dart';
import 'package:hotel_room_booking/models/booking/booking.dart';
import 'package:hotel_room_booking/repositories/booking_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import '../models/hotel.dart';
import '../repositories/hotel_repository.dart';
import '../repositories/hotel_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {

  getIt.registerLazySingleton<Dio>(() => Dio());
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  final hotelBox = await Hive.openBox<Hotel>('hotels');
  final bookingBox = await Hive.openBox<Booking>('bookings');
  Hive.registerAdapter(HotelAdapter());
  Hive.registerAdapter(BookingAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(CoordinatesAdapter());
  Hive.registerAdapter(RoomTypeAdapter());


  getIt.registerLazySingleton<HotelRepository>(
        () => HotelRepositoryImpl(dio: getIt()),
  );

  getIt.registerLazySingleton<BookingRepository>(
        () => BookingRepository(),
  );

  getIt.registerFactory<HotelListingBloc>(
        () => HotelListingBloc(hotelRepository: getIt()),
  );

  getIt.registerFactory<BookingBloc>(
        () => BookingBloc(bookingRepository: getIt<BookingRepository>()),
  );
}