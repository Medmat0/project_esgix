import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:esgix_project/services/posts/posts_repository/posts_repository.dart';
import 'package:meta/meta.dart';

import '../../model/post.dart';

part 'post_other_event.dart';
part 'post_other_state.dart';

class PostOtherBloc extends Bloc<PostOtherEvent, PostOtherState> {
  final PostsRepository postsRepository;
  PostOtherBloc({required this.postsRepository,}) : super(const PostOtherState()) {
    on<GetCommentsPostEvent>(_onGetCommentsPost);
    on<LikePostsByUserEvent>(_onLikePostsByUser);
  }

  void _onGetCommentsPost(GetCommentsPostEvent event, Emitter<PostOtherState> emit) async {
    emit(state.copyWith(status: PostOtherStatus.loading));
    try {
      final posts = await postsRepository.getCommentsPost(event.idPost, event.page, event.offset);
      final hasMoreData = posts.isNotEmpty;
      emit(state.copyWith(
        status: PostOtherStatus.success,
        posts: state.posts + posts,
        hasMoreData: hasMoreData,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: PostOtherStatus.error));
    }
  }

  void _onLikePostsByUser(LikePostsByUserEvent event, Emitter<PostOtherState> emit) async {
    emit(state.copyWith(status: PostOtherStatus.loading));
    try {
      final posts =
      await postsRepository.getPostsByUserLiked(event.page, event.offset, event.userId);
      emit(state.copyWith(
        status: PostOtherStatus.success,
        posts: posts,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: PostOtherStatus.error));
    }
    return;
  }
}
