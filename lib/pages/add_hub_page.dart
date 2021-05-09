import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/values/config.dart';
import 'package:home_automation_system/viewmodels/add_new_hub_viewmodel.dart';
import 'package:home_automation_system/widgets/device_item.dart';
import 'package:home_automation_system/widgets/device_item_view.dart';
import 'package:provider/provider.dart';

class AddHubPage extends StatefulWidget {
  const AddHubPage({Key? key}) : super(key: key);

  @override
  _AddHubPageState createState() => _AddHubPageState();
}

class _AddHubPageState extends State<AddHubPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddNewHubViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add New Hub"),
        ),
        body: Consumer<AddNewHubViewModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8, top: 24),
                              child: Text("Enter the hub details below", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                            ),
                            Text("Please find your hub Id from the device", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),

                            Container(height: 24,),
                            TextFormField(
                              controller: model.hubName,
                              cursorColor: Colors.grey,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                labelText: "Hub Name",
                                contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                                labelStyle: TextStyle(
                                    color: AppColors.SECONDARY_COLOR
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 24, right: 16),
                                  child: Icon(Icons.drive_file_rename_outline, color: AppColors.SECONDARY_COLOR,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.SECONDARY_COLOR),
                                  borderRadius:BorderRadius.circular(AppConfig.TEXT_FIELD_BORDER_RADIUS),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.SECONDARY_COLOR),
                                    borderRadius:BorderRadius.circular(AppConfig.TEXT_FIELD_BORDER_RADIUS)
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.SECONDARY_COLOR),
                                    borderRadius:BorderRadius.circular(AppConfig.TEXT_FIELD_BORDER_RADIUS)
                                ),
                                hintStyle: TextStyle(
                                    color: AppColors.LIGHT_SECONDARY_COLOR,
                                    fontSize: 18
                                ),
                                focusColor: AppColors.SECONDARY_COLOR,
                                fillColor: AppColors.SECONDARY_COLOR,
                                hoverColor: AppColors.SECONDARY_COLOR,
                              ),

                              validator: (value) {
                                if (value!.length > 0){
                                  return null;
                                }
                                return "Hub Name cannot be empty";
                              },
                            ),
                            Container(height: 12,),
                            TextFormField(
                              controller: model.hubId,
                              cursorColor: Colors.grey,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                labelText: "Hub Id",
                                contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                                labelStyle: TextStyle(
                                    color: AppColors.SECONDARY_COLOR
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 24, right: 16),
                                  child: Icon(Icons.confirmation_number_sharp, color: AppColors.SECONDARY_COLOR,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.SECONDARY_COLOR),
                                  borderRadius:BorderRadius.circular(AppConfig.TEXT_FIELD_BORDER_RADIUS),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.SECONDARY_COLOR),
                                    borderRadius:BorderRadius.circular(AppConfig.TEXT_FIELD_BORDER_RADIUS)
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.SECONDARY_COLOR),
                                    borderRadius:BorderRadius.circular(AppConfig.TEXT_FIELD_BORDER_RADIUS)
                                ),
                                hintStyle: TextStyle(
                                    color: AppColors.LIGHT_SECONDARY_COLOR,
                                    fontSize: 18
                                ),
                                focusColor: AppColors.SECONDARY_COLOR,
                                fillColor: AppColors.SECONDARY_COLOR,
                                hoverColor: AppColors.SECONDARY_COLOR,
                              ),

                              validator: (value) {
                                if (value != null && value.length > 3){
                                  return null;
                                }
                                if (value!.length < 4){
                                  return "Hub Id must be at least 4 characters";
                                }
                                return "Hub Id cannot be empty";
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: ElevatedButton(
                                onPressed: !model.isLoading ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text('Creating new hub....')));
                                    bool result = await model.addNewHub();
                                    if (result){
                                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                      AutoRouter.of(context).pop();
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('This hub is already assigned to a user or Something went wrong please try again')));
                                    }
                                  }
                                } : null,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.MAIN_COLOR,
                                    side: BorderSide(width: 1, color: Colors.transparent),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(AppConfig.BUTTON_BORDER_RADIUS- 4))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: Text('Create new hub'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    model.hubDeviceList != null && model.hubDeviceList!.length > 0 ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        children: [
                          Text("Available Devices", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ) : Container(),
                    Expanded(
                      child: model.hubDeviceList != null && model.hubDeviceList!.length > 0 ?  ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: model.hubDeviceList!.map((e) => DeviceItemView(
                          deviceModel: e,
                          onTap: (){
                          },
                        )).toList(),
                      ) : Container(),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
