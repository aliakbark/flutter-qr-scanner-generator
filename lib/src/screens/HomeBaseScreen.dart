import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gismachinetest/src/app_localizations.dart';
import 'package:gismachinetest/src/screens/home.dart';

class HomeBaseScreen extends StatefulWidget {
  @override
  _HomeBaseScreenState createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  final GlobalKey<ScaffoldState> _homeScaffoldKey =
      new GlobalKey<ScaffoldState>();

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
      key: _homeScaffoldKey,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            PlaceHolderScreen(
                title: AppLocalizations.of(context).translate('outbreak')),
            PlaceHolderScreen(
                title: AppLocalizations.of(context).translate('chatbot')),
            PlaceHolderScreen(
                title: AppLocalizations.of(context).translate('forum'))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        selectedFontSize: 16.0,
        unselectedFontSize: 14.0,
        selectedLabelStyle: Theme.of(context).textTheme.subhead,
        unselectedLabelStyle: Theme.of(context).textTheme.body1,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black45,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                AppLocalizations.of(context).translate('home'),
              ),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
              ),
              title: Text(
                AppLocalizations.of(context).translate('outbreak'),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            title: Text(
              AppLocalizations.of(context).translate('chatbot'),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.forum,
              ),
              title: Text(
                AppLocalizations.of(context).translate('forum'),
              )),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }
}

class PlaceHolderScreen extends StatelessWidget {
  final String title;

  PlaceHolderScreen({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(this.title),
      ),
    );
  }
}
