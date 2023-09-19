import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/resources/auth_material.dart';
import 'package:instagram_clone/responsive/responsive.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../responsive/mobileScreen.dart';
import '../responsive/webScren.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>();
  Uint8List? image;
  final ImagePicker picker = ImagePicker();
  Future<Uint8List> picImgFromGallary() async {
    final XFile? im = await picker.pickImage(source: ImageSource.gallery);
    Uint8List image1 = await im!.readAsBytes();
    return image1;
  }

  static String emailpattern =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regex = RegExp(emailpattern);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                color: primaryColor,
              ),
              SizedBox(
                height: 30.h,
              ),
              //for profile
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: image != null
                        ? MemoryImage(image!) as ImageProvider
                        : const NetworkImage(
                            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fprofile%2F&psig=AOvVaw0Kopv_ccO7J8s2gUWlOv1i&ust=1693459431586000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCKC_6JDSg4EDFQAAAAAdAAAAABAE"),
                    backgroundColor: Colors.amber,
                  ),
                  image == null
                      ? Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                              onPressed: () async {
                                image = await picImgFromGallary();

                                setState(() {});
                              },
                              icon: Icon(Icons.add_a_photo_outlined)))
                      : const Text("")
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    customTextField((val) {
                      if (val == null) {
                        return "Enter your username";
                      } else if (val.length < 6) {
                        return "username must contains 6 characters";
                      }
                    }, _usernameController, "Enter your user name", context,
                        kebordType: TextInputType.text),
                    const SizedBox(
                      height: 24,
                    ),
                    customTextField((val) {
                      if (val == null) {
                        return "Enter your email";
                      } else if (regex.hasMatch(val) != true) {
                        return "Enter your valid email";
                      }
                    }, _emailController, "Enter your Email", context,
                        kebordType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 24,
                    ),
                    customTextField((val) {
                      if (val == null) {
                        return "Enter your password";
                      } else if (val.length < 6) {
                        return "your password is too weak";
                      }
                    }, _passController, "Enter your Password", context,
                        obscureText: true),
                    const SizedBox(
                      height: 24,
                    ),
                    customTextField((val) {
                      if (val == null) {
                        return "Enter your bio";
                      } else if (val.length < 10) {
                        return "your bio must contains at least 10 characters";
                      }
                    }, _bioController, "Enter your bio", context,
                        kebordType: TextInputType.text),
                    const SizedBox(
                      height: 24,
                    ),
                    customButton(() async {
                      if (_formKey.currentState!.validate()) {
                        String result = await AuthMethods().signup(context,
                            email: _emailController.text.trim(),
                            password: _passController.text.trim(),
                            bio: _bioController.text.trim(),
                            username: _usernameController.text.trim(),
                            file: image!);
                        if (result == "success") {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const ResponsiveLayout(
                                webScreenLayout: WebScreen(),
                                mobileScreenLayout: MobileScreen());
                          }));
                        }
                      }
                    }, "Sign up"),
                  ],
                ),
              ),

              SizedBox(
                height: 12.h,
              ),
              Flexible(flex: 2, child: Container()),
              Text.rich(
                TextSpan(children: [
                  const TextSpan(text: "Already  have an  account? "),
                  TextSpan(
                      text: "Log in",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        })
                ]),
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
