import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/constants/device_types.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/values/colors.dart';

class DeviceItem extends StatefulWidget {
  final DeviceModel deviceModel;
  final Function onTap;
  const DeviceItem({Key? key, required this.deviceModel, required this.onTap}) : super(key: key);

  @override
  _DeviceItemState createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: AppColors.BACK_WHITE_COLOR,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          child: Row(
            children: [
              Icon(DeviceTypes.ICONS_MAP[widget.deviceModel.deviceType], size: 32,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.deviceModel.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(height: 4,),
                      Wrap(
                        children: [
                          Text("Id: ${widget.deviceModel.id}   |   Type: ${widget.deviceModel.deviceType}   |   Hub: ${widget.deviceModel.hubName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              widget.deviceModel.isLoadingStatus == null || !widget.deviceModel.isLoadingStatus! ?  Padding(
                padding: const EdgeInsets.only(left: 8),
                child: InkWell(
                  splashColor: Colors.amber,
                  borderRadius: BorderRadius.circular(40),
                    onTap: (){
                      widget.onTap();
                    },
                    child: Icon(Icons.power, color: widget.deviceModel.status != null && widget.deviceModel.status! ? Colors.amber : Colors.grey[200], size: 40,)
                ),
              ) :
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: InkWell(
                    splashColor: Colors.amber,
                    borderRadius: BorderRadius.circular(40),
                    onTap: (){
                      widget.onTap();
                    },
                    child: SpinKitFadingCircle(size: 24, color: Colors.grey,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
