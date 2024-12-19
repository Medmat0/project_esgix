import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_pagination_event.dart';
part 'post_pagination_state.dart';

class PostPaginationBloc extends Bloc<PostPaginationEvent, PostPaginationState> {
  PostPaginationBloc() : super(PostPaginationInitial()) {
    on<PostPaginationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
