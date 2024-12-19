import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_interaction_event.dart';
part 'post_interaction_state.dart';

class PostInteractionBloc extends Bloc<PostInteractionEvent, PostInteractionState> {
  PostInteractionBloc() : super(PostInteractionInitial()) {
    on<PostInteractionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
