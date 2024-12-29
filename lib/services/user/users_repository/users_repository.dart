import 'package:esgix_project/services/user/local_users_data_source/local_users_data_source.dart';
import 'package:esgix_project/services/user/users_data_source/users_data_source.dart';

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
      return userSave;
    } catch (error) {
      return user;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      return await remoteDataSource.loginUser(email, password);
    } catch (error) {
      return false;
    }
  }

  Future<User> findUserById(String id) async {
    final user = await remoteDataSource.findUserById(id);
    return user;
  }

  Future<List<User>> findListUsersByLikedIdPost(String idPost) async {
    final users = await remoteDataSource.findListUsersByLikedIdPost(idPost);
    return users;
  }

  Future<User> updateUser(String userId, String? username, String? avatar,
      String? description) async {
    final user = await remoteDataSource.updateUser(
        userId, username, avatar, description);
    return user;
  }
}
