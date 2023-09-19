import 'package:get/get.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/Screens/singup_screen.dart';
import 'package:instagram_clone/responsive/mobileScreen.dart';
import 'package:instagram_clone/responsive/webScren.dart';

import '../responsive/responsive.dart';

const String login = "/login";
const String signup = "/sign-up";
const String webscreen = "/web-home";
const String mobilescreen = "/home";
List<GetPage> getpages = [
  GetPage(name: login, page: () => LoginScreen()),
  GetPage(name: signup, page: () => SignUpScreen()),
  GetPage(name: webscreen, page: () => WebScreen()),
  GetPage(name: mobilescreen, page: () => MobileScreen()),
];
