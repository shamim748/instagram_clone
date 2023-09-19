import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:instagram_clone/style/appstyle.dart';
import 'package:uuid/uuid.dart';

class FireStorMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImg,
  ) async {
    String result = "Some error occurred";
    try {
      String postId = const Uuid().v1();
      String photoUrl =
          await StorageMethod().uploadImgToStorage("posts", file, true);
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImg: profileImg,
          likes: []);
      _firebaseFirestore.collection("posts").doc(postId).set(post.tojson());
      result = "success";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> likepost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firebaseFirestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      Get.showSnackbar(AppStyle().FailedSnackbar(e.toString()));
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firebaseFirestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "profilepic": profilePic,
          "name": name,
          "uid": uid,
          "text": text,
          "commentid": commentId,
          "datePublished": DateTime.now()
        });
      } else {
        AppStyle().FailedSnackbar("text is empty");
      }
    } catch (e) {
      AppStyle().FailedSnackbar(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firebaseFirestore.collection("user").doc(uid).get();
      List following = (snap.data()! as dynamic)["following"];
      if (following.contains(followId)) {
        await _firebaseFirestore.collection("user").doc(followId).update({
          "followers": FieldValue.arrayRemove([uid])
        });
        await _firebaseFirestore.collection("user").doc(followId).update({
          "following": FieldValue.arrayRemove([followId])
        });
      } else {
        await _firebaseFirestore.collection("user").doc(followId).update({
          "followers": FieldValue.arrayUnion([uid])
        });
        await _firebaseFirestore.collection("user").doc(followId).update({
          "following": FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      AppStyle().FailedSnackbar(e.toString());
    }
  }

  Future<void> signout() async {
    FirebaseAuth.instance.signOut();
  }
}
