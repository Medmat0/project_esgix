  import 'package:bloc/bloc.dart';
  import 'package:esgix_project/app_exception.dart';
  import 'package:esgix_project/model/post.dart';
  import 'package:esgix_project/services/posts/posts_repository/posts_repository.dart';
  import 'package:flutter/cupertino.dart';

  import '../../services/dio_service.dart';

  part 'post_event.dart';

  part 'post_state.dart';

  class PostBloc extends Bloc<PostEvent, PostState> {
    final PostsRepository postsRepository;

    PostBloc({required this.postsRepository}) : super(const PostState()) {
      on<PostLikeEvent>(_onLikePost);
    }

    Future<void> _onLikePost(PostLikeEvent event, Emitter<PostState> emit) async {
      emit(state.copyWith(status: PostBlocStatus.loading));
      try {
        checkIfIHaveTheTokenForPathSecurise();
        await postsRepository.likeAPost(event.id);
        emit(state.copyWith(
          status: PostBlocStatus.likePostSuccess,
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
  }
