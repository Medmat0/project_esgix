class SessionManager {
  // Instance unique du singleton
  static final SessionManager _instance = SessionManager._internal();

  // Constructeur privé
  SessionManager._internal();

  // Accès global au singleton
  static SessionManager get instance => _instance;

  // Token utilisateur (modifiable)
  String? token;

  String? userId;

  String? email;

  String? username;

  String? avatar;

  String? description;

  void setUserName(String? newUsername) {
    username = newUsername;
  }

  void setUserAvatar(String? newAvatar) {
    avatar = newAvatar;
  }

  void setUserDescription(String? newDescription) {
    description = newDescription;
  }

  String? getUserName(){
    return username;
  }

  String? getUserAvatar(){
    return avatar;
  }

  String? getUserDescription(){
    return description;
  }



  // Définit ou met à jour le token
  void setToken(String? newToken) {
    token = newToken;
  }

  void setEmail(String? newEmail) {
    email = newEmail;
  }


  void setUserId(String? newUserId) {
    userId = newUserId;
  }

  String? getUserId(){
    return userId;
  }

  String? getEmail(){
    return email;
  }

  void clearEmail() {
    email = null;
  }

  void clearUserId() {
    userId = null;
  }

  void clearAll(){
    token = null;
    userId = null;
    email = null;
    username = null;
    avatar = null;
    description = null;
  }

  void clearUsername() {
    username = null;
  }

  void clearAvatar() {
    avatar = null;
  }

  void clearDescription() {
    description = null;
  }



  // Supprime le token
  void clearToken() {
    token = null;
  }

  String? getToken(){
    return token;
  }

  String getBearerToken(){
    return "Bearer ${token!}";
  }

  // Vérifie si un token est défini
  bool get hasToken => token != null;
}
