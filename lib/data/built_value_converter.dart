import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import '../model/serializers.dart';

import '../model/built_post.dart';

class BuiltValueConverter extends JsonConverter {
  @override
  Request convertRequest(Request request) {
    return super.convertRequest(
      request.copyWith(
        body: serializers.serializeWith(
            serializers.serializerForType(request.body.runtimeType)!,
            request.body),
      ),
    );
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, T>(
      Response response) async {
    final Response dynamicResponse = await super.convertResponse(response);
    final BodyType customBody = _convertToCustomObject<T>(dynamicResponse.body);
    return dynamicResponse.copyWith<BodyType>(body: customBody);
  }

  dynamic _convertToCustomObject<T>(dynamic element) {
    if (element is BuiltPost) {
      return element;
    }
    if (element is List) {
      return _deserializeListOf<T>(element);
    } else {
      return _deserialize<T>(element);
    }
  }

  BuiltList<T> _deserializeListOf<T>(List dynamicList) {
    return BuiltList<T>(dynamicList.map((element) => _deserialize<T>(element)));
  }

  T _deserialize<T>(Map<String, dynamic> value) {
    return serializers.deserializeWith(
      serializers.serializerForType(T)!,
      value,
    );
  }
}
