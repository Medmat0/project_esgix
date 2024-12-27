import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../app_exception.dart';

part 'post_interaction_event.dart';
part 'post_interaction_state.dart';

class PostInteractionBloc extends Bloc<PostInteractionEvent, PostInteractionState> {
  PostInteractionBloc() : super(const PostInteractionState()) {
    on<PostInteractionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
