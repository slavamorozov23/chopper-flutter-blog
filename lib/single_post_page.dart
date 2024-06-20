import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'model/built_post.dart';

import 'data/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  SinglePostPage({super.key, required this.postId});

  int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чоппер блог'),
      ),
      body: FutureBuilder<Response<BuiltPost>>(
          future: Provider.of<PostApiService>(context).getPost(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final post = snapshot.data!.body!;
              return _buildPost(post);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Padding _buildPost(BuiltPost post) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(post.title),
          const SizedBox(
            height: 12,
          ),
          Text(post.body)
        ],
      ),
    );
  }
}
