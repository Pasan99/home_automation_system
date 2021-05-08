import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/home_model.dart';
import 'package:home_automation_system/values/colors.dart';

class HomeItem extends StatefulWidget {
  final HomeModel homeModel;
  const HomeItem({Key? key, required this.homeModel}) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: AppColors.BACK_WHITE_COLOR,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Row(
            children: [
              Icon(CupertinoIcons.home, size: 32,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.homeModel.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Container(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.homeModel., style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
