import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../models/hotel.dart';
import 'hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository {
  final Dio dio;

  HotelRepositoryImpl({required this.dio});

  @override
  Future<List<Hotel>> getHotels() async {
    // try {
      final response = await dio.get(
        'https://67ad8c763f5a4e1477de05d0.mockapi.io/hotels',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<Hotel> hotels = data.map((hotel) => Hotel.fromJson(hotel)).toList();

        return hotels;
      } else {
        throw Exception('Failed to load hotels');
      }
    // } on DioException catch (e) {
    //   throw Exception('Failed to load hotels: ${e.message}');
    // }
  }



}