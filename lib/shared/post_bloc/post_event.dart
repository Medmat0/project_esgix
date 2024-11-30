part of 'post_bloc.dart';

@immutable
sealed class PostEvent {
  const PostEvent();
}

class PostAddEvent extends PostEvent {
  final Post post;

  const PostAddEvent({
    required this.post,
  });
}

class PostDeleteEvent extends PostEvent {
  final String idPost;

  const PostDeleteEvent({
    required this.idPost,
  });
}

class PostFindOneEvent extends PostEvent {
  final String idPost;

  const PostFindOneEvent({
    required this.idPost,
  });
}

class PostUpdateEvent extends PostEvent {
  final Post post;

  const PostUpdateEvent({
    required this.post,
  });
}

class PostLikeEvent extends PostEvent {
  final String id;

  const PostLikeEvent({
    required this.id,
  });
}

class PostSearchEvent extends PostEvent {
  final String content;

  const PostSearchEvent({
    required this.content,
  });
}

class PostOffsetEvent extends PostEvent {
  final int offset;
  final int page;

  const PostOffsetEvent({
    required this.offset,
    required this.page,
  });
}
