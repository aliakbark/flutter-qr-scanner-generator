import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gismachinetest/src/app_localizations.dart';
import 'package:gismachinetest/src/managers/object_factory.dart';
import 'package:gismachinetest/src/screens/QRScreen.dart';
import 'package:gismachinetest/src/utilities/app_language.dart';
import 'package:gismachinetest/src/utilities/constants.dart';
import 'package:gismachinetest/src/utilities/ui_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              height: 120.0,
              padding: EdgeInsets.all(16.0),
              color: Colors.black12,
              alignment: Alignment.bottomCenter,
              child: Text(
                AppLocalizations.of(context).translate('drawer_title'),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('qr')),
              leading: Icon(Icons.settings_overscan),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QRScreen()));
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('exit')),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
                exit(0);
              },
            )
          ],
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  pinned: true,
                  forceElevated: true,
                  expandedHeight: 250,
                  title: Container(
                    height: kToolbarHeight / 1.8,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('search_hint'),
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.black),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: _bannerImageSlider(context),
                  ),
                  actions: <Widget>[
//                    IconButton(icon: Icon(Icons.search), onPressed: () {})
                  ],
                ),
              ];
            },
            body: Container(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('title'),
                      ),
                      subtitle: Text(
                          AppLocalizations.of(context).translate('message')),
                    ),
                  );
                },
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (ObjectFactory().prefs.getLanguageCode == 'en') {
            appLanguage.changeLanguage(Locale('ar'));
          } else {
            appLanguage.changeLanguage(Locale('en'));
          }
        },
        tooltip: 'Change language',
        label: Text(_getLabel),
        icon: Icon(Icons.swap_horiz),
      ),
    );
  }

  String get _getLabel {
    if (ObjectFactory().prefs.getLanguageCode == 'en') {
      return 'عربى';
    } else {
      return 'ENGLISH';
    }
  }

  //create full screen Carousel with context
  CarouselSlider _bannerImageSlider(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 250,
        viewportFraction: 1.0,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: Constants.bannerImageList.map(
        (url) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: screenWidth(context),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
