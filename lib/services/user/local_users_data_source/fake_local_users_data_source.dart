import 'package:esgix_project/model/user.dart';

import 'local_users_data_source.dart';

class FakeLocalUsersDataSource implements LocalUsersDataSource {
  @override
  Future<User> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> findListUsersByLikedIdPost(String idPost) {
    // TODO: implement findListUsersByLikedIdPost
    throw UnimplementedError();
  }

  @override
  Future<User> findUserById(String id) {
    // TODO: implement findUserById
    throw UnimplementedError();
  }

  @override
  Future<bool> loginUser(String email, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(String userId, String? username, String? avatar,
      String? description) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}