import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_bloc/view/profile_page.dart';
import 'package:movie_app_bloc/view/tvseries_home_page.dart';

import '../constants/app_icons.dart';
import '../constants/app_text.dart';
import 'movies_home_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const [
            MoviesHomePage(),
            TvSeriesHomePage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
            title: Text(BottomNavBarPageText.moviesText),
            icon: Icon(BottomNavBarPageIcons.movieIcon),
          ),
          BottomNavyBarItem(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
            title: Text(BottomNavBarPageText.tvSeriesText),
            icon: Icon(BottomNavBarPageIcons.tvSeriesIcon),
          ),
          BottomNavyBarItem(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
            title: Text(BottomNavBarPageText.profileText),
            icon: Icon(BottomNavBarPageIcons.profileIcon),
          )
        ],
      ),
    );
  }
}
