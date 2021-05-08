import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/fragments/devices_fragment.dart';
import 'package:home_automation_system/fragments/home_fragment.dart';
import 'package:home_automation_system/fragments/profile_fragment.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<String> _titles = <String>[
    "Hubs",
    "Devices",
    "Profile"
  ];
  List<Widget> _actions = <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Icon(
        Icons.add,
      ),
    ),
    Container(),
    Container()
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    DevicesFragment(),
    ProfileFragment()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,

        title: Text(_titles[_selectedIndex]),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: (){
              if (_selectedIndex == 0){
                // add home
                AutoRouter.of(context).navigate(AddHubPageRoute());
              }
            },
            child: _actions[_selectedIndex],
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Hubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.MAIN_COLOR,
        onTap: _onItemTapped,
      ),
    );
  }
}
