import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/hub_model.dart';
import 'package:home_automation_system/values/colors.dart';

class HubItem extends StatefulWidget {
  final HubModel homeModel;
  final Function onTap;
  const HubItem({Key? key, required this.homeModel, required this.onTap}) : super(key: key);

  @override
  _HubItemState createState() => _HubItemState();
}

class _HubItemState extends State<HubItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: AppColors.BACK_WHITE_COLOR,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            widget.onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
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
                          Text(widget.homeModel.devicesCount.toString() + " devices  ( ID: ${widget.homeModel.id} )", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
