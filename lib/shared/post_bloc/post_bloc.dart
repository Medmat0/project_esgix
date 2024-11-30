import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:esgix_project/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../services/dio_service.dart';
import '../../services/error_service.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<PostAddEvent>(_onAddPost);
    on<PostDeleteEvent>(_onDeletePost);
    on<PostFindOneEvent>(_onFindOnePost);
    on<PostLikeEvent>(_onLikePost);
    on<PostUpdateEvent>(_onUpdatePost);
    on<PostOffsetEvent>(_onOffsetPagePost);
    on<PostSearchEvent>(_onSearchPost);
  }

  Future<void> _onAddPost(PostAddEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final userPostAdd = await _addPost(event.post);
      emit(state.copyWith(
        status: PostBlocStatus.addPostSuccess,
        posts: [userPostAdd],
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to add a message"),
      ));
    }
  }

  Future<void> _onDeletePost(
      PostDeleteEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      await _deletePost(event.idPost);
      emit(state.copyWith(
        status: PostBlocStatus.deletePostSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to delete a message"),
      ));
    }
  }

  Future<void> _onFindOnePost(
      PostFindOneEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      await _findOnPostById(event.idPost);
      emit(state.copyWith(
        status: PostBlocStatus.findOnePostSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to find one message"),
      ));
    }
  }

  Future<void> _onUpdatePost(
      PostUpdateEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final postUpdate = await _updatePost(event.post);
      emit(state.copyWith(
        status: PostBlocStatus.updatePostSuccess,
        posts: [postUpdate],
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to find one message"),
      ));
    }
  }

  Future<void> _onLikePost(PostLikeEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      await _likeAPost(event.id);
      emit(state.copyWith(
        status: PostBlocStatus.findOnePostSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to like a message"),
      ));
    }
  }

  Future<void> _onSearchPost(
      PostSearchEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final posts = await _searchPost(event.content);
      emit(state.copyWith(
        status: PostBlocStatus.searchPostSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to search a messages"),
      ));
    }
  }

  Future<void> _onOffsetPagePost(
      PostOffsetEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostBlocStatus.loading));
    try {
      final posts = await _getPostByOffset(event.page, event.offset);
      emit(state.copyWith(
        status: PostBlocStatus.offsetPagePostSuccess,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostBlocStatus.error,
        exception: PostException(message: "don't success to search a messages"),
      ));
    }
  }

  Future<Post> _addPost(Post post) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.post(
      "${dotenv.env['BASE_URL']}posts/register",
      data: post.toJson(),
    );
    return Post.fromJson(response.data);
  }

  Future<bool> _deletePost(String id) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.delete(
      "${dotenv.env['BASE_URL']}posts/$id",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return true;
  }

  Future<Post> _findOnPostById(String id) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}posts/$id",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return Post.fromJson(response.data);
  }

  Future<Post> _updatePost(Post post) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.put("${dotenv.env['BASE_URL']}posts/${post.id}",
        data: post.toJson());
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return Post.fromJson(response.data);
  }

  Future<bool> _likeAPost(String id) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.put(
      "${dotenv.env['BASE_URL']}likes/$id",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    return true;
  }

  Future<List<Post>> _searchPost(String content) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}search?query=$content",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data['posts'] as List;
    return jsonList.map((jsonElement) => Post.fromJson(jsonElement)).toList();
  }

  Future<List<Post>> _getPostByOffset(int page, int offset) async {
    checkIfIHaveTheTokenForPathSecurise();
    final dio = makeTheHeaderWithApiKey();
    final response = await dio.get(
      "${dotenv.env['BASE_URL']}posts?page=$page&offset=$offset",
    );
    final statusCode = response.statusCode;
    if (statusCode != 200) whatTypeOfError(statusCode!);
    final jsonList = response.data['posts'] as List;
    return jsonList.map((jsonElement) => Post.fromJson(jsonElement)).toList();
  }
}
