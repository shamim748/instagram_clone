import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:instagram_clone/style/appstyle.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<model.User> getuserDetails() async {
    //following User provided by firebase
    User currentuser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("user").doc(currentuser.uid).get();
    Get.back();
    return model.User.fromSnap(snap);
  }

  //sign up or create a new account
  Future<String> signup(context,
      {required String email,
      required String password,
      required String bio,
      required String username,
      required Uint8List file}) async {
    String result = "An error is occurred";
    try {
      AppStyle().progressDialog(context);
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty ||
          file.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String profileUrl =
            await StorageMethod().uploadImgToStorage("profile", file, false);
        model.User user = model.User(
            email: email,
            uid: credential.user!.uid,
            username: username,
            bio: bio,
            followers: [],
            following: [],
            photourl: profileUrl);
        _firestore
            .collection("user")
            .doc(credential.user!.uid)
            .set(user.tojson());
        result = "success";
        Get.back();
        Get.showSnackbar(AppStyle().SuccesSnackbar("Account is created"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = "The password provided is too weak.";
        Get.back();
        Get.showSnackbar(AppStyle().FailedSnackbar(result));
      } else if (e.code == 'email-already-in-use') {
        result = "The account already exists for that email.";
        Get.back();
        Get.showSnackbar(AppStyle().FailedSnackbar(result));
      }
    } catch (e) {
      result = e.toString();
      Get.showSnackbar(AppStyle().FailedSnackbar(result));
    }
    return result;
  }

  //sign in or login into existing account

  Future<String> login(
    context, {
    required String email,
    required String password,
  }) async {
    String result = "An error is occurred";
    try {
      AppStyle().progressDialog(context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      result = "success";
      Get.back();
      Get.showSnackbar(AppStyle().SuccesSnackbar("Login success fully"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        result = "No user found for that email.";
        Get.showSnackbar(AppStyle().FailedSnackbar(result));
      } else if (e.code == 'wrong-password') {
        Get.back();
        result = "Wrong password provided for that user.";
        Get.showSnackbar(AppStyle().FailedSnackbar(result));
      }
    }
    return result;
  }

  //sign out
  Future<void> signout() async {
    await _auth.signOut();
  }
}
