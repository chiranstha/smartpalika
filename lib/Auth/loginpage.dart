// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use, avoid_print, unused_element, no_leading_underscores_for_local_identifiers, invalid_return_type_for_catch_error, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:nb_utils/nb_utils.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../Widgets/constants.dart';
import '../config/my_config.dart';
import '../helper/constants.dart';
import '../services/app_navigator_service.dart';
import '../services/baseDio.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<void> login() async {
    if (_loginKey.currentState!.validate()) {
      showLoginDialog(context);
      var data = {
        'userNameOrEmailAddress': usernameCtrl.value.text,
        'password': passwordCtrl.value.text,
      };

      try {
        var responss = await Api().post(MyConfig.loginURL, data: data);
        print(responss.statusCode);

        if (responss.statusCode == 200) {
          var token = json.decode(responss.data)['result']['accessToken'];

          await setValue(accessToken, token);
          Navigator.pop(context);
          AppNavigatorService.pushNamedAndRemoveUntil('home');
        }
      } catch (e) {
        Navigator.pop(context);
        print(e.toString());
      }
    }
  }

  bool offsecureText1 = true;

  void _onlockPressed1() {
    if (offsecureText1 == true) {
      setState(() {
        offsecureText1 = false;
        lockIcon = LockIcon().open;
      });
    } else {
      setState(() {
        offsecureText1 = true;
        lockIcon = LockIcon().lock;
      });
    }
  }

  Icon lockIcon = LockIcon().lock;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _loginKey,
            child: Column(
              children: [
                Container(
                  height: height * 0.25,
                  width: double.infinity,
                  color: bluesColor,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/images/loginimg.png"),
                  //         fit: BoxFit.fill)),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.03),
                      child: Text(
                        "साइन इन गर्नुहोस्",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.06, vertical: height * 0.04),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(fontSize: 18),
                        controller: usernameCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: InputDecoration(
                          hintText: "प्रयोगकर्ता नाम",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 18),
                        controller: passwordCtrl,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: lockIcon,
                              onPressed: () => _onlockPressed1()),
                          hintText: "पासवर्ड",
                        ),
                        obscureText: offsecureText1,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6,
                              errorText:
                                  "Password should be minimum 6 characters"),
                        ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bluesColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => login(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: width * 0.02,
                                  horizontal: width * 0.04),
                              child: Text(
                                "लगइन",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class LockIcon {
  Icon lock = Icon(
    Icons.visibility_off,
    size: 20,
  );
  Icon open = Icon(
    Icons.visibility,
    size: 20,
  );
}

showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              width: 40,
            ),
            Text("Loading...")
          ],
        ),
      );
    },
  );
}
