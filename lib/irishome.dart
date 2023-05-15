import 'package:flutter/material.dart';
import 'package:irisproject/interfaces/otherspage.dart';
import 'package:irisproject/interfaces/camerapage.dart';
import 'package:irisproject/interfaces/welcomepage.dart';
import 'package:irisproject/popup/SettingsPage.dart';
import 'package:irisproject/popup/ContactPage.dart';
import 'package:irisproject/popup/AboutPage.dart';

class irishome extends StatefulWidget {
  var cameras;
  irishome(this.cameras);
  @override
  _irishomeState createState() => _irishomeState();
}

class _irishomeState extends State<irishome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85.0), // here the desired height
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 22, 83),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                onselect(context, value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(
                        Icons.anchor_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                      Text("| Contact"),
                    ]),
                    value: "Contact",
                  ),
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 20,
                      ),
                      Text("| Settings"),
                    ]),
                    value: "Settings",
                  ),
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 20,
                      ),
                      Text("| About"),
                    ]),
                    value: "About",
                  ),
                ];
              },
            )
          ],
          title: const Text(" IRIS Application"),
          centerTitle: true,
          elevation: 1,
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Color(0xff37C4B9),
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.app_registration)),
              ]),
        ),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        camerapage(widget.cameras),
        welcomepage(),
        otherspage(),
      ]),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.camera_outlined),
              label: const Text("Scan your IRiS"),
              onPressed: () {
                _tabController.animateTo((_tabController.index + 1) % 2);
                print(_tabController.index);
              })
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onselect(BuildContext context, String value) {
    switch (value) {
      case 'Settings':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      case 'Contact':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactPage()));
        break;
      case 'About':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AboutPage()));
        break;
    }
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }
}
