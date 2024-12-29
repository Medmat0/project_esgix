part of 'post_other_bloc.dart';

@immutable
sealed class PostOtherEvent {
  const PostOtherEvent();
}

class GetCommentsPostEvent extends PostOtherEvent {
  final String idPost;
  final int page;
  final int offset;

  const GetCommentsPostEvent({
    required this.idPost,
    required this.page,
    required this.offset,
  });
}

class LikePostsByUserEvent extends PostOtherEvent {
  final String userId;
  final int page;
  final int offset;

  const LikePostsByUserEvent({
    required this.userId,
    required this.page,
    required this.offset,
  });
}
