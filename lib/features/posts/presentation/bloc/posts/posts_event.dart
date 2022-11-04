part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class getAllPostsEvent extends PostsEvent{}

class RefreshPostsEvent extends PostsEvent{}


