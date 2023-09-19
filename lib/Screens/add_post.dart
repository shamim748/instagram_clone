import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/userProvider.dart';
import 'package:instagram_clone/resources/fireStore_methods.dart';
import 'package:instagram_clone/style/appstyle.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _captionController = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  Uint8List? image;
  RxBool _isLoading = true.obs;
  void clearImg() {
    setState(() {
      image = null;
    });
  }

  void postImage(String uid, String username, String profileImg) async {
    try {
      _isLoading.value = false;
      String result = await FireStorMethods().uploadPost(
          _captionController.text, image!, uid, username, profileImg);
      if (result == "success") {
        _isLoading.value = true;
        clearImg();

        Get.showSnackbar(AppStyle().SuccesSnackbar("Post"));
      } else {
        _isLoading.value = true;
        Get.showSnackbar(AppStyle().SuccesSnackbar(result));
      }
    } catch (e) {
      _isLoading.value = true;
      Get.showSnackbar(AppStyle().SuccesSnackbar(e.toString()));
    }
  }

  final ImagePicker picker = ImagePicker();
  _selectImage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final XFile? im =
                      await picker.pickImage(source: ImageSource.camera);
                  image = await im!.readAsBytes();
                  setState(() {});
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final XFile? im =
                      await picker.pickImage(source: ImageSource.gallery);
                  image = await im!.readAsBytes();
                  setState(() {});
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return image == null
        ? Center(
            child: IconButton(
                onPressed: () => _selectImage(context),
                icon: const Icon(
                  Icons.upload,
                  size: 40.0,
                )),
          )
        : Scaffold(
            key: scaffoldkey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: () => clearImg(),
                  icon: const Icon(Icons.arrow_back)),
              title: const Text("Post to"),
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.uid, user.username, user.photourl),
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ))
              ],
            ),
            body: Column(
              children: [
                Obx(
                  () => _isLoading.value == false
                      ? const LinearProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photourl),
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth * .4,
                      child: TextField(
                        controller: _captionController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption ...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(image!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter)),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          );
  }
}
