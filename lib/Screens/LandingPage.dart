import 'package:flutter/material.dart';
import 'package:twenty4_hours/Screens/FavoritesPage.dart';
import 'package:twenty4_hours/Screens/HomePage.dart';
import 'package:twenty4_hours/Screens/TopPicksForUser.dart';
import 'package:twenty4_hours/Screens/TopicSelectionPage.dart';
import 'package:twenty4_hours/Utils/SharedPreference.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if(sharedPrefs.interactedSections!=null && sharedPrefs.interactedSections!.isNotEmpty&&_children.length<4){
      _children.add(const TopPicksForUser());
    }
  }

  List<Widget> _children = [];

  @override
  void initState() {
    _children.add(const HomePage(title: "Twenty4 Hours News"));
    _children.add(const FavoritesPage());
    _children.add(const TopicSelectionPage());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items:  [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Customize',
          ),
          if(sharedPrefs.interactedSections!=null && sharedPrefs.interactedSections!.isNotEmpty)
            const BottomNavigationBarItem(
              icon: Icon(Icons.recommend_rounded),
              label: 'Top Picks',
            ),
        ],
      ),
    );
  }
}

