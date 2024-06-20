library built_vehicle;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

import '../../../model/serializers.dart';

part 'built_vehicle.g.dart';

abstract class BuiltVehicle
    implements Built<BuiltVehicle, BuiltVehicleBuilder> {
  VehicleType get type;
  String get brand;
  // поля можно сделть с поддержкой null, при помощи "тип_переменной ?"
  double get price;
  BuiltList<String> get passengerNames;

  BuiltVehicle._();

  factory BuiltVehicle([void Function(BuiltVehicleBuilder) updates]) =
      _$BuiltVehicle;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltVehicle.serializer, this));
  }

  static BuiltVehicle fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltVehicle.serializer, json.decode(jsonString))!;
  }

  static Serializer<BuiltVehicle> get serializer => _$builtVehicleSerializer;
}

class VehicleType extends EnumClass {
  static const VehicleType car = _$car;
  static const VehicleType motorbike = _$motorbike;
  static const VehicleType train = _$train;
  static const VehicleType plane = _$plane;

  const VehicleType._(super.name);

  static BuiltSet<VehicleType> get values => _$values;
  static VehicleType valueOf(String name) => _$valueOf(name);
  static Serializer<VehicleType> get serializer => _$vehicleTypeSerializer;
}
