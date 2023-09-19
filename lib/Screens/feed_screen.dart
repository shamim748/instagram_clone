import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/widgets/post_card.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});
  QuerySnapshot<Map<String, dynamic>>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          "assets/images/ic_instagram.svg",
          color: primaryColor,
          height: 32,
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.messenger_outline))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            data = snapshot.data!;
            // if (snapshot.hasData) {
            //   return ListView.builder(
            //       itemCount: snapshot.data!.docs.length,
            //       itemBuilder: (context, index) {
            //         return PostCard(
            //           snap: snapshot.data!.docs[index].data(),
            //         );
            //       });
            // }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    snap: data!.docs[index].data(),
                  );
                });
            //   return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
