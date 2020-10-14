class UserDataResponse {
  String message;
  bool success;
  Profile profile;

  UserDataResponse({
    this.message,
    this.profile,
    this.success,
  });

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    success = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }

  UserDataResponse.withError(String errorValue)
      : message = errorValue,
        success = false;
}

class Profile {
  String id;
  String userAccountId;
  String firstName;
  String lastName;
  String birthday;
  String email;
  String profilePhotoUrl;
  String preferredFoot;
  String preferredPosition;
  int numberOfTimesPlayedWeekly;

  Profile({
    this.id,
    this.userAccountId,
    this.firstName,
    this.lastName,
    this.birthday,
    this.email,
    this.profilePhotoUrl,
    this.preferredFoot,
    this.preferredPosition,
    this.numberOfTimesPlayedWeekly,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userAccountId = json['userAccountId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthday = json['birthday'];
    email = json['email'];
    profilePhotoUrl = json['profilePhotoUrl'];
    preferredFoot = json['preferredFoot'];
    preferredPosition = json['preferredPosition'];
    numberOfTimesPlayedWeekly = json['numberOfTimesPlayedWeekly'];
  }

  Profile.initial()
      : firstName = '',
        lastName = '',
        birthday = '',
        email = '',
        profilePhotoUrl = '',
        preferredFoot = 'Left',
        preferredPosition = '',
        numberOfTimesPlayedWeekly = 1;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userAccountId'] = this.userAccountId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['profilePhotoUrl'] = this.profilePhotoUrl;
    data['preferredFoot'] = this.preferredFoot;
    data['preferredPosition'] = this.preferredPosition;
    data['numberOfTimesPlayedWeekly'] = this.numberOfTimesPlayedWeekly;
    return data;
  }

  Map<String, dynamic> toJsonProfileUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['birthday'] = this.birthday;
    data['profilePhotoUrl'] = this.profilePhotoUrl;
    data['preferredFoot'] = this.preferredFoot;
    data['preferredPosition'] = this.preferredPosition;
    data['numberOfTimesPlayedWeekly'] = this.numberOfTimesPlayedWeekly;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
