import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'model/built_post.dart';
import 'data/post_api_service.dart';
import 'single_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newPost = BuiltPost((b) => b
            ..title = 'New Title'
            ..body = "New Body");
          final response =
              await Provider.of<PostApiService>(context, listen: false)
                  .postPost(newPost);
          print(response.body);
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response<BuiltList<BuiltPost>>>(
        future: Provider.of<PostApiService>(context, listen: false).getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            // final List posts = json.decode(snapshot.data!.bodyString);
            final posts = snapshot.data!.body!;
            return _buildPosts(context, posts);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  ListView _buildPosts(BuildContext context, BuiltList<BuiltPost> posts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].title,
            ),
            subtitle: Text(posts[index].body),
            onTap: () => _navigateToPost(context, posts[index].id ?? 0),
          ),
        );
      },
      padding: const EdgeInsets.all(8),
      itemCount: posts.length,
    );
  }

  void _navigateToPost(BuildContext context, int id) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SinglePostPage(postId: id)));
  }
}
