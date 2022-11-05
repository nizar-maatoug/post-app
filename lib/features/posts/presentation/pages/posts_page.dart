import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return LoadingWidget();
        } else if (state is LoadedPostsState) {
          return PostListWidget(posts: state.posts);
        } else if (state is ErrorPostsState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return LoadingWidget();
        }
      }),
    );
  }
}
