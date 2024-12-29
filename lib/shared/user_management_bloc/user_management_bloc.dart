import 'package:bloc/bloc.dart';
import 'package:esgix_project/app_exception.dart';
import 'package:meta/meta.dart';

import '../../model/user.dart';
import '../../services/dio_service.dart';
import '../../services/user/users_repository/users_repository.dart';

part 'user_management_event.dart';

part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final UsersRepository usersRepository;

  UserManagementBloc({required this.usersRepository})
      : super(const UserManagementState()) {
    on<UserRegisterEvent>(_onAddUser);
    on<UserLoginEvent>(_onLoginUser);
    on<UserUpdateEvent>(_onUpdateUser);
  }

  void _onAddUser(
      UserRegisterEvent event, Emitter<UserManagementState> emit) async {
    emit(state.copyWith(status: UserManagementStatus.addUser));
    try {
      final userInsert = await usersRepository.addUser(event.user);
      emit(state.copyWith(
        status: UserManagementStatus.successAddingUser,
        user: userInsert,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserManagementStatus.error));
    }
    return;
  }

  void _onLoginUser(
      UserLoginEvent event, Emitter<UserManagementState> emit) async {
    emit(state.copyWith(status: UserManagementStatus.loginUser));
    try {
      await usersRepository.loginUser(event.email, event.password);
      emit(state.copyWith(
        status: UserManagementStatus.successLoginUser,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserManagementStatus.error));
    }
    return;
  }

  void _onUpdateUser(
      UserUpdateEvent event, Emitter<UserManagementState> emit) async {
    emit(state.copyWith(status: UserManagementStatus.updateUser));
    try {
      checkIfIHaveTheTokenForPathSecurise();
      final user = await usersRepository.updateUser(
          event.userId, event.username, event.username, event.description);
      emit(state.copyWith(
        status: UserManagementStatus.successUpdateUser,
        user: user,
      ));
    } on UnauthorizedPathWithNoToken catch (_) {
      emit(state.copyWith(status: UserManagementStatus.errorNotLogin));
    } on Exception catch (_) {
      emit(state.copyWith(status: UserManagementStatus.error));
    }
    return;
  }
}
