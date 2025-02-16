import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../bloc/hotel_listing_bloc/hotel_listing_bloc.dart';
import '../models/hotel.dart';
import '../repositories/hotel_repository.dart';
import '../repositories/hotel_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {

  getIt.registerLazySingleton<Dio>(() => Dio());
  final hotelBox = await Hive.openBox<Hotel>('hotels');


  getIt.registerLazySingleton<HotelRepository>(
        () => HotelRepositoryImpl( dio: getIt()),
  );

  // BLoCs
  getIt.registerFactory<HotelListingBloc>(
        () => HotelListingBloc(hotelRepository: getIt()),
  );
}