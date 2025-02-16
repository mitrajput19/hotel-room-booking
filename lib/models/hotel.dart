import 'package:hive/hive.dart';

part 'hotel.g.dart';

@HiveType(typeId: 0)
class Hotel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  double? rating;

  @HiveField(4)
  double? pricePerNight;

  @HiveField(5)
  String? mainImage;

  @HiveField(6)
  Location? location;

  @HiveField(7)
  List<String>? amenities;

  @HiveField(8)
  int? availableRooms;

  @HiveField(9)
  List<RoomType>? roomTypes;

  Hotel({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.pricePerNight,
    this.mainImage,
    this.location,
    this.amenities,
    this.availableRooms,
    this.roomTypes,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rating: (json['rating'] as num?)?.toDouble(),
      pricePerNight: (json['price_per_night'] as num?)?.toDouble(),
      mainImage: json['main_image'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      amenities: json['amenities'] != null ? List<String>.from(json['amenities']) : null,
      availableRooms: json['available_rooms'],
      roomTypes: json['room_types'] != null
          ? (json['room_types'] as List<dynamic>)
          .map((e) => RoomType.fromJson(e))
          .toList()
          : null,
    );
  }
}

@HiveType(typeId: 1)
class Location extends HiveObject {
  @HiveField(0)
  String? address;

  @HiveField(1)
  String? city;

  @HiveField(2)
  String? country;

  @HiveField(3)
  Coordinates? coordinates;

  Location({
    this.address,
    this.city,
    this.country,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'],
      city: json['city'],
      country: json['country'],
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
    );
  }
}

@HiveType(typeId: 2)
class Coordinates extends HiveObject {
  @HiveField(0)
  double? latitude;

  @HiveField(1)
  double? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}

@HiveType(typeId: 3)
class RoomType extends HiveObject {
  @HiveField(0)
  String? type;

  @HiveField(1)
  double? price;

  @HiveField(2)
  int? capacity;

  RoomType({
    this.type,
    this.price,
    this.capacity,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      type: json['type'],
      price: (json['price'] as num?)?.toDouble(),
      capacity: json['capacity'],
    );
  }
}
