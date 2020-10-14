class AuthResponse {
  String message;
  String token;
  bool profileUpdated;
  bool newUser;
  bool success;

  AuthResponse({
    this.message,
    this.token,
    this.profileUpdated,
    this.newUser,
    this.success,
  });

  AuthResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    profileUpdated = json['profile_updated'] == 0 ? false : true;
    newUser = json['new_user'] == 0 ? false : true;
    success = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['profile_updated'] = this.profileUpdated;
    data['new_user'] = this.newUser;
    data['success'] = this.success;
    return data;
  }

  AuthResponse.withError(String errorValue)
      : message = errorValue,
        success = false;
}
