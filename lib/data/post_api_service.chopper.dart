// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PostApiService;

  @override
  Future<Response<dynamic>> getPosts() {
    final Uri $url = Uri.parse('/posts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPost(int id) {
    final Uri $url = Uri.parse('/posts/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPost(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/posts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
