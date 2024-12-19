import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_management_event.dart';
part 'post_management_state.dart';

class PostManagementBloc extends Bloc<PostManagementEvent, PostManagementState> {
  PostManagementBloc() : super(PostManagementInitial()) {
    on<PostManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
