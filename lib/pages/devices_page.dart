import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/constants/device_types.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/viewmodels/devices_viewmodel.dart';
import 'package:home_automation_system/widgets/device_item.dart';
import 'package:intl/intl.dart';
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
            return Column(
              children: [
                Material(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(DateFormat('hh:mm').format(DateTime.now()), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                            Text(DateFormat('  a').format(DateTime.now()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Today : " + DateFormat('yyyy/mm/dd').format(DateTime.now()), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Container(height: 12,),
                        Row(
                          children: [
                            Text("${model.totalKwhForToday.toStringAsFixed(2)}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                            Text("  Kwh", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Power usage for today", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: model.devices != null && model.devices!.length > 0 ?  ListView(
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
                  Container(),
                )
              ],
            );
          }
        ),
      )
    );
  }
}
