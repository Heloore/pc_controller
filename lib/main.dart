import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:pc_controll/repositories/settings_repository.dart';

import 'modules/input/screen/input_card.dart';
import 'modules/settings/screen/settings_card.dart';
import 'modules/system_controlls/screens/sys_controlls_card.dart';
import 'modules/volume/screen/volume_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // TODO: remove
  static final myTabbedPageKey = GlobalKey<_MyHomePageState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Controller',
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
  int _currentIndex = 0;

  @override
  void initState() {
    _checkSavedIPAddress();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // remove and create separate screen for settings
  void _checkSavedIPAddress() async {
    try {
      await SettingsRepository().initAddressToController();
      return;
    } catch (_) {}
    animateToPage(3);
  }

  void animateToPage(int page) {
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
        title: Text(pages[_currentIndex].title),
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
          children: pages.map((pagesItem) => pagesItem.page).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        key: MyApp.myTabbedPageKey,
        selectedIndex: _currentIndex,
        onItemSelected: animateToPage,
        items: pages.map((pagesItem) => pagesItem.bottomNavyBarItem).toList(),
      ),
    );
  }
}

List<PageControllerPage> pages = [
  PageControllerPage("Volume", VolumeCard(), BottomNavyBarItem(title: Text("Volume"), icon: Icon(Icons.volume_up))),
  PageControllerPage("Input", InputCard(), BottomNavyBarItem(title: Text("Input"), icon: Icon(Icons.mouse))),
  PageControllerPage("Controlls", SystemControllsCard(), BottomNavyBarItem(title: Text("Controlls"), icon: Icon(Icons.computer))),
  PageControllerPage("Settings", SettingsCard(), BottomNavyBarItem(title: Text("Settings"), icon: Icon(Icons.settings))),
];

class PageControllerPage {
  final String title;
  final Widget page;
  final BottomNavyBarItem bottomNavyBarItem;

  const PageControllerPage(this.title, this.page, this.bottomNavyBarItem);
}
