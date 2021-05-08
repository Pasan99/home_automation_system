import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';
import 'package:home_automation_system/values/config.dart';
import 'package:home_automation_system/viewmodels/login_page_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ChangeNotifierProvider(
      create: (context) => LoginPageViewModel(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
                "assets/images/img_login.JPG",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Consumer<LoginPageViewModel>(
              builder: (context, model, child) {
                return Positioned(
                  bottom: 24,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.75,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                      child: Material(
                        borderRadius: BorderRadius.circular(14),
                        elevation: 25,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8, top: 24),
                                  child: Text("Welcome back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                ),

                                Container(height: 24,),
                                TextFormField(
                                  controller: model.emailController,
                                  cursorColor: Colors.grey,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                                    labelStyle: TextStyle(
                                        color: AppColors.SECONDARY_COLOR
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(left: 24, right: 16),
                                      child: Icon(Icons.email, color: AppColors.SECONDARY_COLOR,),
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
                                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString());
                                    if (emailValid){
                                      return null;
                                    }
                                    return "Email is not valid";
                                  },
                                ),
                                Container(height: 12,),
                                TextFormField(
                                  controller: model.passwordController,
                                  cursorColor: Colors.grey,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                                    labelStyle: TextStyle(
                                        color: AppColors.SECONDARY_COLOR
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(left: 24, right: 16),
                                      child: Icon(Icons.vpn_key, color: AppColors.SECONDARY_COLOR,),
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
                                    if (value != null && value.length > 6){
                                      return null;
                                    }
                                    if (value!.length < 6){
                                      return "Password must be at least 6 characters";
                                    }
                                    return "Password Cannot be empty";
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _isLoading = true;
                                      if (_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text('Authenticating User....')));
                                        bool result = await model.loginUser();
                                        if (result){
                                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                          _isLoading = false;
                                          AutoRouter.of(context).popAndPush(HomePageRoute());
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(content: Text('Email & password is not matched')));
                                          _isLoading = false;
                                        }
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(width: 1, color: Colors.transparent),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(AppConfig.BUTTON_BORDER_RADIUS))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          child: Text('Login'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(child: Text("Don't have a account yet?"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
