import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/services/navigation_service.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
   final NavigationService navigationService = Get.put(NavigationService());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: NavigationBar(
         selectedIndex: navigationService.currIndex.value,
        onDestinationSelected: (value) => navigationService.updateIndex(value),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 60,
        indicatorColor: Colors.transparent,
        animationDuration: const Duration(microseconds: 500),
        destinations: const <Widget> [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "home",
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(icon: Icon(Icons.search_outlined), label: "search",
            selectedIcon: Icon(Icons.search),
          ),
          NavigationDestination(icon: Icon(Icons.add_outlined), label: "add",
            selectedIcon: Icon(Icons.add),
          ),
          NavigationDestination(icon: Icon(Icons.favorite_outlined), label: "notifications",
            selectedIcon: Icon(Icons.favorite),
          ),
          NavigationDestination(icon: Icon(Icons.person_2_outlined), label: "profile",
            selectedIcon: Icon(Icons.person_2),
          ),
        ],
      ),
    body: AnimatedSwitcher(
      duration: const Duration(microseconds: 500),
      switchInCurve: Curves.ease,
      switchOutCurve: Curves.easeInOut,
      child: navigationService.pages()[navigationService.currIndex.value],
      ),
    ));
  }
}
