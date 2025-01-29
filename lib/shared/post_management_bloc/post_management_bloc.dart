import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:meta/meta.dart';

import '../../model/post.dart';
import '../../services/posts/posts_repository/posts_repository.dart';
import '../post_pagination_bloc/post_pagination_bloc.dart';

part 'post_management_event.dart';
part 'post_management_state.dart';

class PostManagementBloc extends Bloc<PostManagementEvent, PostManagementState> {
  final PostsRepository postsRepository;

  PostManagementBloc({required this.postsRepository}) : super(const PostManagementState()) {
    on<PostManagementAddEvent>(_onAddPost);
    on<PostManagementDeleteEvent>(_onDeletePost);
    on<PostManagementFindOneEvent>(_onFindOnePost);
    on<PostManagementUpdateEvent>(_onUpdatePost);
  }


  Future<void> _onAddPost(PostManagementAddEvent event, Emitter<PostManagementState> emit) async {
    emit(state.copyWith(status: PostManagementStatus.loading));
    try {
      final userPostAdd = await postsRepository.savePost(event.post);
      emit(state.copyWith(
        status: PostManagementStatus.addPostSuccess,
        post: userPostAdd,
      ));


    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostManagementStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostManagementStatus.error,
        exception: PostException(message: "don't success to add a post"),
      ));
    }
  }

  Future<void> _onDeletePost(PostManagementDeleteEvent event, Emitter<PostManagementState> emit) async {
    emit(state.copyWith(status: PostManagementStatus.loading));
    try {
      await postsRepository.deletePost(event.idPost);
      emit(state.copyWith(
        status: PostManagementStatus.deletePostSuccess,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostManagementStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostManagementStatus.error,
        exception: PostException(message: "don't success to delete a post"),
      ));
    }
  }

  Future<void> _onFindOnePost(
      PostManagementFindOneEvent event,
      Emitter<PostManagementState> emit,
      ) async {
    emit(state.copyWith(status: PostManagementStatus.loading));

    try {
      final post = await postsRepository.findOnPostById(event.idPost);
      emit(state.copyWith(
        status: PostManagementStatus.success,
        post: post,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostManagementStatus.error,
        exception: PostException(message: "Failed to fetch post: $error"),
      ));
    }
  }

  Future<void> _onUpdatePost(PostManagementUpdateEvent event, Emitter<PostManagementState> emit) async {
    emit(state.copyWith(status: PostManagementStatus.loading));
    try {
      final postUpdate = await postsRepository.updatePost(event.post);
      emit(state.copyWith(
        status: PostManagementStatus.updatePostSuccess,
        post: postUpdate,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: PostManagementStatus.errorNotLogin));
    } catch (error) {
      emit(state.copyWith(
        status: PostManagementStatus.error,
        exception: PostException(message: "don't success to find one post"),
      ));
    }
  }
}
