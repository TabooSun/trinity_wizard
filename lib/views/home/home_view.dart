import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/theme/app_colors.dart';
import 'package:trinity_wizard/views/home/home_view_model.dart';
import 'package:trinity_wizard/views/my_contacts/my_contacts_view.dart';
import 'package:trinity_wizard/views/my_profile/my_profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel vm = Get.find<HomeViewModel>();

  int _bottomNavigationBarIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        onPressed: () {
          throw UnimplementedError();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        selectedIconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
        currentIndex: _bottomNavigationBarIndex,
        onTap: (int index) {
          _bottomNavigationBarIndex = index;
          setState(() {});
          _pageController.jumpToPage(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox.square(
              dimension: 22,
              child: Image.asset(
                _bottomNavigationBarIndex == 0
                    ? 'assets/images/home.png'
                    : 'assets/images/home_unselected.png',
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          _bottomNavigationBarIndex = index;
          setState(() {});
        },
        children: const <Widget>[
          MyContactsView(),
          MyProfileView(),
        ],
      ),
    );
  }
}
