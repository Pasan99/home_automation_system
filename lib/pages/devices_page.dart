import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/constants/device_types.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/viewmodels/devices_viewmodel.dart';
import 'package:home_automation_system/widgets/device_item.dart';
import 'package:provider/provider.dart';

class DevicesPage extends StatefulWidget {
  final String hubId;
  const DevicesPage({ Key? key, required this.hubId}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devices ( ID : ${widget.hubId} )"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => DevicesViewModel(hubId: widget.hubId),
        child: Consumer<DevicesViewModel>(
            builder: (context, model, child) {
              return model.devices != null && model.devices!.length > 0 ?  ListView(
                children: model.devices!.map((e) => DeviceItem(
                  deviceModel: e,
                  onTap: (){
                    model.switchStatus(e);
                  },
                )).toList(),
              ) : model.devices == null ? Center(child: SpinKitPulse(size: 50, color: AppColors.MAIN_COLOR,)) :
              Container();
            }
        ),
      )
    );
  }
}
