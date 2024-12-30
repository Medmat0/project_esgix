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
      final userSave = await remoteDataSource.addUser(user);
      return userSave;
  }

  Future<bool> loginUser(String email, String password) async {
       return await remoteDataSource.loginUser(email, password);
  }

  Future<User> findUserById(String id) async {
    return await remoteDataSource.findUserById(id);
  }

  Future<List<User>> findListUsersByLikedIdPost(String idPost) async {
    return await remoteDataSource.findListUsersByLikedIdPost(idPost);
  }

  Future<User> updateUser(String userId, String? username, String? avatar,
      String? description) async {
    return await remoteDataSource.updateUser(
        userId, username, avatar, description);
  }
}
