import 'package:esgix_project/services/user/local_users_data_source/local_users_data_source.dart';
import 'package:esgix_project/services/user/users_data_source/users_data_source.dart';

import '../../../app_exception.dart';
import '../../../model/user.dart';

class UsersRepository {
  final UsersDataSource remoteDataSource;
  final LocalUsersDataSource localUsersDataSource;

  UsersRepository({
    required this.remoteDataSource,
    required this.localUsersDataSource,
  });

  Future<User> addUser(User user) async {

    try {
      final userSave = await remoteDataSource.addUser(user);
      //localUsersDataSource.addUser(userSave);
      return userSave;
    } on AppException catch (e) {
      throw e;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {

      return await remoteDataSource.loginUser(email, password);

    } on AppException catch (e) {
      throw e;
    }
  }

  Future<User> findUserById(String id) async {
    try {
      final user = await remoteDataSource.findUserById(id);
      localUsersDataSource.addUser(user);
      return user;
    } catch (error) {
      return localUsersDataSource.findUserById(id);
    }
  }

  Future<List<User>> findListUsersByLikedIdPost(String idPost) async {
    try {
      final users = await remoteDataSource.findListUsersByLikedIdPost(idPost);
      //localUsersDataSource.addUsers(users);
      return users;
    } catch (error) {
      return localUsersDataSource.findListUsersByLikedIdPost(idPost);
    }
  }

  Future<User> updateUser(String userId, String? username, String? avatar,
      String? description) async {
    try {
      final user = await remoteDataSource.updateUser(
          userId, username, avatar, description);
      localUsersDataSource.addUser(user);
      return user;
    } catch (error) {
      return localUsersDataSource.findUserById(userId);
    }
  }
}