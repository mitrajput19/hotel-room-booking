// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 4;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      id: fields[0] as String?,
      hotel: fields[1] as Hotel?,
      checkIn: fields[2] as DateTime?,
      checkOut: fields[3] as DateTime?,
      rooms: fields[4] as int?,
      guests: fields[5] as int?,
      totalPrice: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hotel)
      ..writeByte(2)
      ..write(obj.checkIn)
      ..writeByte(3)
      ..write(obj.checkOut)
      ..writeByte(4)
      ..write(obj.rooms)
      ..writeByte(5)
      ..write(obj.guests)
      ..writeByte(6)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
