import '../models/hotel.dart';

abstract class HotelRepository {
  Future<List<Hotel>> getHotels();
}