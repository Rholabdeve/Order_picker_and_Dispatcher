import 'package:delivery_man/model/user_session_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionController {
  SessionController._internal();

  static final SessionController _instance = SessionController._internal();

  static SessionController get instance => _instance;

  UserSession userSession = UserSession();

  Future<void> setSession(String? id, String? username, String? email,
      String? wareHouseId, String? firstName, String? lastName) async {
    userSession.loginData = LoginData(
        id: id, username: username, email: email, wareHouseId: wareHouseId);

    const storage = FlutterSecureStorage();
    await storage.write(key: 'id', value: id);
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'wareHouseId', value: wareHouseId);
    await storage.write(key: 'firstName', value: firstName);
    await storage.write(key: 'lastName', value: lastName);
  }

  Future<void> loadSession() async {
    const storage = FlutterSecureStorage();
    final id = await storage.read(key: 'id');
    final username = await storage.read(key: 'username');
    final email = await storage.read(key: 'email');
    final wareHouseId = await storage.read(key: 'wareHouseId');
    final firstName = await storage.read(key: 'firstName');
    final lastName = await storage.read(key: 'lastName');

    userSession.loginData = LoginData(
        id: id,
        username: username,
        email: email,
        wareHouseId: wareHouseId,
        firstName: firstName,
        lastName: lastName);

    // print(userSession.loginData?.id);
    // print(userSession.loginData?.username);
    // print(userSession.loginData?.email);
    // print(userSession.loginData?.wareHouseId);
    // print(userSession.loginData?.firstName);
    // print(userSession.loginData?.lastName);
  }

  Future<void> clearSession() async {
    userSession.loginData = LoginData();

    const storage = FlutterSecureStorage();
    await Future.wait([
      storage.delete(key: 'id'),
      storage.delete(key: 'username'),
      storage.delete(key: 'email'),
      storage.delete(key: 'wareHouseId'),
      storage.delete(key: 'firstName'),
      storage.delete(key: 'lastName'),
    ]);
  }
}
