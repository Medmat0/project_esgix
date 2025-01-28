import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../app_exception.dart';
import '../../model/post.dart';
import '../../services/posts/posts_repository/posts_repository.dart';

part 'post_pagination_event.dart';
part 'post_pagination_state.dart';

class PostPaginationBloc extends Bloc<PostPaginationEvent, PostPaginationState> {
  final PostsRepository postsRepository;

  PostPaginationBloc({required this.postsRepository}) : super(const PostPaginationState()) {
    on<PostPaginationLikeEvent>(_onOffsetPagePostByUserLiked);
    on<PostPaginationOffsetEvent>(_onOffsetPagePost);
    on<PostPaginationSearchEvent>(_onSearchPost);
    on<PostPaginationByUserEvent>(_onOffsetPagePostByUser);
  }

  Future<void> _onOffsetPagePostByUserLiked(
      PostPaginationLikeEvent event, Emitter<PostPaginationState> emit) async {
    emit(state.copyWith(status: PostPaginationStatus.loading));
    try {
      final posts =
      await postsRepository.getPostsByUserLiked(event.page, event.offset, event.userId);
      emit(state.copyWith(
        status: PostPaginationStatus.offsetPagePostByUserLikedSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostPaginationStatus.error,
        exception: PostException(message: "don't success to have  a posts"),
      ));
    }
  }

  Future<void> _onSearchPost(PostPaginationSearchEvent event, Emitter<PostPaginationState> emit) async {
    emit(state.copyWith(status: PostPaginationStatus.loading));
    try {
      final posts = await postsRepository.searchPost(event.content);
      emit(state.copyWith(
        status: PostPaginationStatus.searchPostSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostPaginationStatus.error,
        exception: PostException(message: "don't success to search a post"),
      ));
    }
  }

  Future<void> _onOffsetPagePost(PostPaginationOffsetEvent event, Emitter<PostPaginationState> emit,
      ) async {
    emit(state.copyWith(status: PostPaginationStatus.loading));

    try {
      final posts = await postsRepository.getPostByOffset(event.page, event.offset);

      final hasMoreData = posts.isNotEmpty;

      final updatedPosts = (event.offset == 0 && event.page == 0) ? posts : state.posts + posts;

      emit(state.copyWith(
        status: PostPaginationStatus.offsetPagePostSuccess,
        posts: updatedPosts,
        hasMoreData: hasMoreData,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostPaginationStatus.error,
        exception: PostException(message: "Failed to fetch posts"),
      ));
    }
  }
  Future<void> _onOffsetPagePostByUser(PostPaginationByUserEvent event, Emitter<PostPaginationState> emit) async {
    emit(state.copyWith(status: PostPaginationStatus.loading));
    try {
      final posts = await postsRepository.getPostsByUser(event.offset, event.page, event.userId);
      emit(state.copyWith(
        status: PostPaginationStatus.success,
        posts: posts,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostPaginationStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostPaginationStatus.error,
        exception: PostException(message: "don't success to fetch posts by user"),
      ));
    }
  }
}
