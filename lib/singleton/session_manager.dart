class SessionManager {
  // Instance unique du singleton
  static final SessionManager _instance = SessionManager._internal();

  // Constructeur privé
  SessionManager._internal();

  // Accès global au singleton
  static SessionManager get instance => _instance;

  // Token utilisateur (modifiable)
  String? token;

  // Définit ou met à jour le token
  void setToken(String? newToken) {
    token = newToken;
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
