import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'built_value_converter.dart';
import '../model/built_post.dart';
import 'mobile_data_interceptor.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  // @Get(headers: {'some header content type': 'test var = text/plain'})
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts(
      // @Header('heared-test-name') String headerValue,
      );

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<Map<String, dynamic>>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse('https://jsonplaceholder.typicode.com'),
      services: [_$PostApiService()],
      // converter: const JsonConverter(),
      converter: BuiltValueConverter(),
      interceptors: [
        // // const HeadersInterceptor(
        // //     {'Cache-Control': 'no-cache'}), // только демонстрация
        HttpLoggingInterceptor(),
        // CurlInterceptor(), // очищенный вывод HttpLoggingInterceptor
        // LargeFileMobileInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }
}
