import 'package:flutter/material.dart';
import 'package:home_automation_system/widgets/home_item.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeItem(),
      ],
    );
  }
}
