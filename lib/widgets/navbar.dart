// ignore: must_be_immutable

import 'package:delivery_man/const/my_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../view/select_roles/delivery_man/home_screen/home_screen.dart';
import '../view/select_roles/delivery_man/order_history/order_history.dart';
import '../view/select_roles/delivery_man/profile_screen/profile_screen.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      OrderHistory(),
      ProfileScreen(),
    ];
  }

  PersistentTabController controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      padding: const NavBarPadding.only(left: 0, right: 0),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.2,
            blurRadius: 6,
          ),
        ],
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
      navBarHeight: 70,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          iconSize: 26,
          activeColorPrimary: myColor.themeColor,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.history),
          title: ("Order History"),
          iconSize: 26,
          activeColorPrimary: myColor.themeColor,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          iconSize: 26,
          activeColorPrimary: myColor.themeColor,
          inactiveColorPrimary: Colors.grey),
    ];
  }
}
