import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/hub_model.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/viewmodels/hub_viewmodel.dart';
import 'package:home_automation_system/widgets/hub_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HubViewModel(),
      child: Consumer<HubViewModel>(
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
                child: model.hubs != null && model.hubs!.length > 0 ?  ListView(
                  children: model.hubs!.map((e) => HubItem(
                    homeModel: e,
                    onTap: (){
                      AutoRouter.of(context).navigate(DevicesPageRoute(hubId: e.id));
                    },
                  )).toList(),
                ) : model.hubs == null ? Center(child: SpinKitPulse(size: 50, color: AppColors.MAIN_COLOR,)) :
                Container(),
              ),
            ],
          );
        }
      ),
    );
  }
}
