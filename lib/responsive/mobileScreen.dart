import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/utils/color.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import '../model/user.dart' as model;

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final RxInt _currentIndex = 0.obs;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Obx(
          () => CupertinoTabBar(
            currentIndex: _currentIndex.value,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: _currentIndex.value == 0
                        ? primaryColor
                        : secondaryColor,
                  ),
                  label: "",
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined,
                      color: _currentIndex.value == 1
                          ? primaryColor
                          : secondaryColor),
                  label: "",
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline,
                      color: _currentIndex.value == 2
                          ? primaryColor
                          : secondaryColor),
                  label: "",
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border,
                      color: _currentIndex.value == 3
                          ? primaryColor
                          : secondaryColor),
                  label: "",
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: _currentIndex.value == 4
                          ? primaryColor
                          : secondaryColor),
                  label: "",
                  backgroundColor: primaryColor),
            ],
            onTap: (val) {
              _currentIndex.value = val;
              pageController.jumpToPage(_currentIndex.value);
            },
          ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (value) {
            _currentIndex.value = value;
          },
          children: homeScreenItems,
        ));
  }
}
