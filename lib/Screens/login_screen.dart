import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/Screens/singup_screen.dart';
import 'package:instagram_clone/resources/auth_material.dart';
import 'package:instagram_clone/responsive/mobileScreen.dart';
import 'package:instagram_clone/responsive/webScren.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/widgets/custom_button.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../responsive/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  static String emailpattern =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regex = RegExp(emailpattern);

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldkey,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: ScreenUtil().screenWidth,
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
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
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
                    customButton(() async {
                      if (_formKey.currentState!.validate()) {
                        String result = await AuthMethods().login(context,
                            email: _emailController.text.trim(),
                            password: _passController.text.trim());

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
                    }, "Log in"),
                  ],
                )),
            SizedBox(
              height: 12.h,
            ),
            Flexible(flex: 2, child: Container()),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: "Don't have an  account? "),
                TextSpan(
                    text: "Sign up",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignUpScreen();
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
    );
  }
}
