class UserSession {
  bool? codeStatus;
  String? message;
  LoginData? loginData;

  UserSession({
    this.codeStatus,
    this.message,
    LoginData? loginData,
  }) : loginData = loginData ?? LoginData();

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      codeStatus: json['code_status'],
      message: json['message'],
      loginData: json['login_data'] != null
          ? LoginData.fromJson(json['login_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code_status': codeStatus,
      'message': message,
      'login_data': loginData?.toJson(),
    };
  }
}

class LoginData {
  String? id;
  String? username;
  String? email;
  String? wareHouseId;
  String? firstName;
  String? lastName;

  LoginData(
      {this.id,
      this.username,
      this.email,
      this.wareHouseId,
      this.firstName,
      this.lastName});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      wareHouseId: json['wareHouse_Id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'wareHouse_Id': wareHouseId,
      'first_name': firstName,
      'last_name': lastName
    };
  }
}
