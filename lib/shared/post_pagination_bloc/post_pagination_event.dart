part of 'post_pagination_bloc.dart';

@immutable
sealed class PostPaginationEvent {
  const PostPaginationEvent();
}

class PostPaginationLikeEvent extends PostPaginationEvent {
  final int page;
  final int offset;
  final String userId;

  const PostPaginationLikeEvent({
    required this.offset,
    required this.page,
    required this.userId,
  });
}

class PostPaginationSearchEvent extends PostPaginationEvent {
  final String content;

  const PostPaginationSearchEvent({
    required this.content,
  });
}


class PostPaginationOffsetEvent extends PostPaginationEvent {
  final int offset;
  final int page;

  const PostPaginationOffsetEvent({
    required this.offset,
    required this.page,
  });
}


class PostPaginationByUserEvent extends PostPaginationEvent {
  final int page;
  final int offset;
  final String userId;

  const PostPaginationByUserEvent({
    required this.offset,
    required this.page,
    required this.userId,
  });
}


