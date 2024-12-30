import 'package:delivery_man/view/login_as/login_as.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/login/login_controller.dart';

class Login extends StatefulWidget {
  static var wareHouseId_login;
  final String login_type;
  const Login({Key? key, required this.login_type}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: ChangeNotifierProvider(
        create: (_) => LoginController(),
        child: Consumer<LoginController>(builder: (context, controller, _) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Material(
              child: SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 850,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/screen_bg.jpg',
                          ),
                          fit: BoxFit.fill),
                    ),
                    padding: EdgeInsets.only(top: 50.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Image(
                              height: 200,
                              fit: BoxFit.contain,
                              image: AssetImage(
                                'assets/images/distrho_logo_green.png',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            width: double.maxFinite,
                            child: TextFormField(
                              controller: controller.emailController,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              decoration: const InputDecoration(
                                hintText: 'Enter username',
                                labelText: 'username',
                                border: OutlineInputBorder(),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Icon(Icons.man),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username Is Required";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            width: double.maxFinite,
                            child: TextFormField(
                              controller: controller.passwordController,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                hintText: 'Enter Your Password',
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.togglePasswordVisibility();
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Icon((controller.show_Pass == true)
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                              obscureText: !controller.show_Pass,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password Is Required";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            width: double.maxFinite,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff87C440),
                              ),
                              onPressed: () async {
                                await controller.login(
                                    widget.login_type,
                                    context,
                                    controller.emailController.text,
                                    controller.passwordController.text);
                              },
                              child: controller.saving == true
                                  ? CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    )
                                  : Text('Login'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 45,
                      left: 12,
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
                      ))
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
