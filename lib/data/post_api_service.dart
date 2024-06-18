import 'package:chopper/chopper.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  // @Get(headers: {'some header content type': 'test var = text/plain'})
  @Get()
  Future<Response> getPosts(
      // @Header('heared-test-name') String headerValue,
      );

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse('https://jsonplaceholder.typicode.com'),
      services: [_$PostApiService()],
      converter: const JsonConverter(),
    );
    return _$PostApiService(client);
  }
}