import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/constants/device_types.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/viewmodels/devices_viewmodel.dart';
import 'package:home_automation_system/widgets/device_item.dart';
import 'package:provider/provider.dart';

class DevicesFragment extends StatefulWidget {
  const DevicesFragment({Key? key}) : super(key: key);

  @override
  _DevicesFragmentState createState() => _DevicesFragmentState();
}

class _DevicesFragmentState extends State<DevicesFragment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DevicesViewModel(),
      child: Consumer<DevicesViewModel>(
        builder: (context, model, child) {
          return model.devices != null && model.devices!.length > 0 ?  ListView(
            children: model.devices!.map((e) => DeviceItem(
              deviceModel: e,
              onTap: (){
                model.switchStatus(e);
              },
              onTapItem: (){
                if (e.isContinuouslyRunning) {
                  AutoRouter.of(context).navigate(
                      UsageChartPageRoute(deviceModel: e));
                }
                else{
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Usage is only available for devices which runs continuously. Ex: door does not contain usage history')));
                }
              },
            )).toList(),
          ) : model.devices == null ? Center(child: SpinKitPulse(size: 50, color: AppColors.MAIN_COLOR,)) :
          Container();
        }
      ),
    );
  }
}
