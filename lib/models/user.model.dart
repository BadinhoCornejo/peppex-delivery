class User {
  String uid;
  String email;
  String displayName;
  String photoUrl;

  User({this.uid, this.email, this.displayName, this.photoUrl});

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'],
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "photoUrl": photoUrl
      };
}
