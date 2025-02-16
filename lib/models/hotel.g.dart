// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotelAdapter extends TypeAdapter<Hotel> {
  @override
  final int typeId = 0;

  @override
  Hotel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hotel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      rating: fields[3] as double?,
      pricePerNight: fields[4] as double?,
      mainImage: fields[5] as String?,
      location: fields[6] as Location?,
      amenities: (fields[7] as List?)?.cast<String>(),
      availableRooms: fields[8] as int?,
      roomTypes: (fields[9] as List?)?.cast<RoomType>(),
    );
  }

  @override
  void write(BinaryWriter writer, Hotel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.pricePerNight)
      ..writeByte(5)
      ..write(obj.mainImage)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.amenities)
      ..writeByte(8)
      ..write(obj.availableRooms)
      ..writeByte(9)
      ..write(obj.roomTypes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 1;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      address: fields[0] as String?,
      city: fields[1] as String?,
      country: fields[2] as String?,
      coordinates: fields[3] as Coordinates?,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordinatesAdapter extends TypeAdapter<Coordinates> {
  @override
  final int typeId = 2;

  @override
  Coordinates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coordinates(
      latitude: fields[0] as double?,
      longitude: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Coordinates obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoomTypeAdapter extends TypeAdapter<RoomType> {
  @override
  final int typeId = 3;

  @override
  RoomType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomType(
      type: fields[0] as String?,
      price: fields[1] as double?,
      capacity: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RoomType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.capacity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
