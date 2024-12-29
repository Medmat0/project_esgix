import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:meta/meta.dart';

import '../../model/user.dart';
import '../../services/user/users_repository/users_repository.dart';

part 'user_query_event.dart';
part 'user_query_state.dart';

class UserQueryBloc extends Bloc<UserQueryEvent, UserQueryState> {
  final UsersRepository usersRepository;

  UserQueryBloc({required this.usersRepository}) : super(const UserQueryState()) {
    on<UserByIdEvent>(_onFindUserById);
    on<UserByLikePostEvent>(_onFindUserByLikePost);
  }


  void _onFindUserById(UserByIdEvent event, Emitter<UserQueryState> emit) async {
    emit(state.copyWith(status: UserQueryStatus.findUserById));
    try {
      final user = await usersRepository.findUserById(event.userId);emit(state.copyWith(
        status: UserQueryStatus.success,
        users: [user],
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status:UserQueryStatus.error));
    }
    return;
  }


  void _onFindUserByLikePost(UserByLikePostEvent event, Emitter<UserQueryState> emit) async {
    emit(state.copyWith(status: UserQueryStatus.userByLikePost));
    try {
      final users = await usersRepository.findListUsersByLikedIdPost(event.idPost);
      emit(state.copyWith(
        status: UserQueryStatus.success,
        users: users,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserQueryStatus.error));
    }
    return;
  }
}
