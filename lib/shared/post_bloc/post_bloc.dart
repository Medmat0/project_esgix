import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:esgix_project/model/post.dart';
import 'package:esgix_project/services/posts/posts_repository/posts_repository.dart';
import 'package:flutter/cupertino.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository postsRepository;

  PostBloc({required this.postsRepository}) : super(const PostState()) {
    on<PostAddEvent>(_onAddPost);
    on<PostDeleteEvent>(_onDeletePost);
    on<PostFindOneEvent>(_onFindOnePost);
    on<PostLikeEvent>(_onLikePost);
    on<PostUpdateEvent>(_onUpdatePost);
    on<PostOffsetEvent>(_onOffsetPagePost);
    on<PostSearchEvent>(_onSearchPost);
    on<PostByUserLikedEvent>(_onOffsetPagePostByUserLiked);
    on<PostByUserEvent>(_onOffsetPagePostByUser);
  }

  Future<void> _onAddPost(PostAddEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final userPostAdd = await postsRepository.savePost(event.post);
      emit(state.copyWith(
        status: PostBlocStatus.addPostSuccess,
        posts: [userPostAdd],
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to add a post"),
      ));
    }
  }

  Future<void> _onDeletePost(
      PostDeleteEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      await postsRepository.deletePost(event.idPost);
      emit(state.copyWith(
        status: PostBlocStatus.deletePostSuccess,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostBlocStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to delete a post"),
      ));
    }
  }

  Future<void> _onFindOnePost(
      PostFindOneEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      await postsRepository.findOnPostById(event.idPost);
      emit(state.copyWith(
        status: PostBlocStatus.findOnePostSuccess,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostBlocStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to find one post"),
      ));
    }
  }

  Future<void> _onUpdatePost(
      PostUpdateEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final postUpdate = await postsRepository.updatePost(event.post);
      emit(state.copyWith(
        status: PostBlocStatus.updatePostSuccess,
        posts: [postUpdate],
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostBlocStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to find one post"),
      ));
    }
  }

  Future<void> _onLikePost(PostLikeEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      await postsRepository.likeAPost(event.id);
      emit(state.copyWith(
        status: PostBlocStatus.findOnePostSuccess,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostBlocStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to like a post"),
      ));
    }
  }

  Future<void> _onSearchPost(
      PostSearchEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final posts = await postsRepository.searchPost(event.content);
      emit(state.copyWith(
        status: PostBlocStatus.searchPostSuccess,
        posts: posts,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostBlocStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to search a posts"),
      ));
    }
  }

  Future<void> _onOffsetPagePost(
      PostOffsetEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final posts = await postsRepository.getPostByOffset(event.page, event.offset);
      emit(state.copyWith(
        status: PostBlocStatus.offsetPagePostSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to search a posts"),
      ));
    }
  }

  Future<void> _onOffsetPagePostByUser(
      PostByUserEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final posts =
          await postsRepository.getPostsByUser(event.page, event.offset, event.userId);
      emit(state.copyWith(
        status: PostBlocStatus.offsetPagePostByUserSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to have  a posts"),
      ));
    }
  }

  Future<void> _onOffsetPagePostByUserLiked(
      PostByUserLikedEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final posts =
          await postsRepository.getPostsByUserLiked(event.page, event.offset, event.userId);
      emit(state.copyWith(
        status: PostBlocStatus.offsetPagePostByUserLikedSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to have  a posts"),
      ));
    }
  }
}
