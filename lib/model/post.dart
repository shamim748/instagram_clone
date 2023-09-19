import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImg;
  final likes;
  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profileImg,
      required this.likes});
  Map<String, dynamic> tojson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postid": postId,
        "datepublished": datePublished,
        "posturl": postUrl,
        "profileimg": profileImg,
        "likes": likes
      };
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        postId: snapshot["postid"],
        datePublished: snapshot["datepublished"],
        postUrl: snapshot["posturl"],
        profileImg: snapshot["profileimg"],
        likes: snapshot["likes"]);
  }
}
