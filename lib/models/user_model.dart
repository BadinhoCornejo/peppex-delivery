class UserModel {
  String uid;
  String email;
  String displayName;
  String photoUrl;

  UserModel({this.uid, this.email, this.displayName, this.photoUrl});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  factory UserModel.fromGuest(String uid) {
    return UserModel(
      uid: uid,
      email: '',
      displayName: '',
      photoUrl: '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "photoUrl": photoUrl
      };
}
