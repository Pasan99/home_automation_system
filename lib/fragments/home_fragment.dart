import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/models/hub_model.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/viewmodels/hub_viewmodel.dart';
import 'package:home_automation_system/widgets/hub_item.dart';
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
            return model.hubs != null && model.hubs!.length > 0 ?  ListView(
              children: model.hubs!.map((e) => HubItem(
                homeModel: e,
                onTap: (){
                  AutoRouter.of(context).navigate(DevicesPageRoute(hubId: e.id));
                },
              )).toList(),
            ) : model.hubs == null ? Center(child: SpinKitPulse(size: 50, color: AppColors.MAIN_COLOR,)) :
            Container();
          }
      ),
    );
  }
}
