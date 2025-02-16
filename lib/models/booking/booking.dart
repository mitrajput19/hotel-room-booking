import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../hotel.dart';

part 'booking.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Booking {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final Hotel? hotel;

  @HiveField(2)
  final DateTime? checkIn;

  @HiveField(3)
  final DateTime? checkOut;

  @HiveField(4)
  final int? rooms;

  @HiveField(5)
  final int? guests;

  @HiveField(6)
  final double? totalPrice;

  Booking({
    this.id,
     this.hotel,
     this.checkIn,
     this.checkOut,
     this.rooms,
     this.guests,
     this.totalPrice,
  });


}