import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:pc_controll/modules/input_card.dart';
import 'package:pc_controll/modules/pc_controlls_card.dart';
import 'package:pc_controll/modules/settings_card.dart';
import 'package:pc_controll/repository/repository.dart';

import 'modules/volume/screen/volume_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final myTabbedPageKey = GlobalKey<_MyHomePageState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(key: myTabbedPageKey),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  Repository repository = Repository();
  int _currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  animateToPage(int page) {
    _currentIndex = page;
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nav Bar"),
        actions: _currentIndex == 3
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.language),
                  onPressed: () {
                    print("lang");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () {
                    print("help");
                  },
                ),
              ]
            : null,
      ),
      resizeToAvoidBottomPadding: false,
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            VolumeCard(),
            InputCard(),
            PCControllsCard(),
            SettingsCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        key: MyApp.myTabbedPageKey,
        selectedIndex: _currentIndex,
        onItemSelected: animateToPage,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Volume'), icon: Icon(Icons.volume_up)),
          BottomNavyBarItem(title: Text('Input'), icon: Icon(Icons.mouse)),
          BottomNavyBarItem(title: Text('PC contolls'), icon: Icon(Icons.computer)),
          BottomNavyBarItem(title: Text('Settings'), icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
