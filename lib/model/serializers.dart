library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:chopperandretrofitflutterblog/core/built_value/model/built_vehicle.dart';
import 'built_post.dart';

part 'serializers.g.dart';

@SerializersFor([
  BuiltPost,
  BuiltVehicle,
  VehicleType,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
