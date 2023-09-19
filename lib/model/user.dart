import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String photourl;
  const User(
      {required this.email,
      required this.uid,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photourl});
  Map<String, dynamic> tojson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "profile": photourl,
        "bio": bio,
        "followers": followers,
        "following": following
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot["email"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        bio: snapshot["bio"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        photourl: snapshot["profile"]);
  }
}
