part of 'post_bloc.dart';

@immutable
sealed class PostEvent {
  const PostEvent();
}

class PostLikeEvent extends PostEvent {
  final String id;

  const PostLikeEvent({
    required this.id,
  });
}
