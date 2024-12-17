
import '../../../model/user.dart';

abstract class UsersDataSource {
  Future<User> addUser(User user);

  Future<bool> loginUser(String email, String password);

  Future<User> findUserById(String id);

  Future<List<User>> findListUsersByLikedIdPost(String idPost);

  Future<User> updateUser(String userId, String? username, String? avatar, String? description);

}