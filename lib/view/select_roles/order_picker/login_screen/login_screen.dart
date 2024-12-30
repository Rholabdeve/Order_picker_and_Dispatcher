import 'package:delivery_man/widgets/custom_button.dart';
import 'package:delivery_man/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../../../../controller/api_controller/controllers.dart';
import '../../../../controller/login_order_picker/login_order_picker_controller.dart';
import '../../../login_as/login_as.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    print('Rebuild');
    var mq = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: ChangeNotifierProvider(
        create: (_) => Login_Picker_Controller(),
        child: Consumer<Login_Picker_Controller>(
            builder: (context, controller, _) {
          return Scaffold(
            body: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginAs(),
                                      ));
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Image(
                              height: mq.height * 0.5,
                              // width: mq.width * 1,
                              image: AssetImage(
                                'assets/images/login_vector.png',
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: mq.height * 0.01,
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomTextField(
                              controller: controller.usernameController,
                              hintText: 'Enter Your Username',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return ("Please Enter Your Username");
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Consumer<ApiController>(
                              builder: (context, value, child) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: CustomTextField(
                                validate: (values) {
                                  RegExp regex = RegExp(r'^.{3,}$');
                                  if (values!.isEmpty) {
                                    return ("Password is required for login");
                                  }
                                  if (!regex.hasMatch(values)) {
                                    return ("Enter Valid Password(Min. 3 Character)");
                                  }
                                  if (values.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                obscureText: !value.passwordVisible,
                                controller: controller.passwordController,
                                hintText: 'Enter Your Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    (value.passwordVisible == true)
                                        ? FeatherIcons.eye
                                        : FeatherIcons.eyeOff,
                                    color: Color.fromARGB(255, 211, 0, 70),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      value.hide_UnHide();
                                    });
                                  },
                                ),
                              ),
                            );
                          }),

                          SizedBox(
                            height: mq.height * 0.1,
                          ),
                          // Row(
                          //   children: [
                          //     Checkbox(
                          //       value: false,
                          //       onChanged: (value) {},
                          //     ),
                          //     Text('Remember Me')
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomButton(
                        isLoading: controller.saving_,
                        buttonTextSize: 18,
                        sizeHeight: mq.height * 0.08,
                        onTap: () async {
                          if (controller.formKey.currentState!.validate()) {
                            setState(() {
                              controller.saving_ = true;
                            });
                            await controller.login(context);
                          }
                        },
                        buttonText: 'Login',
                        sizeWidth: double.infinity),
                  ),
                  SizedBox(
                    height: mq.height * 0.015,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
