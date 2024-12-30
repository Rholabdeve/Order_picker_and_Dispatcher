import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            color: myColor.themeColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'My Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                SizedBox(
                  height: mq.height * 0.03,
                ),
                CircleAvatar(radius: 50, child: Icon(CupertinoIcons.person)),
                SizedBox(
                  height: mq.height * 0.03,
                ),
                Text(
                  'Your Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * 0.02,
                ),
                CustomTextField(
                  readonly: true,
                  hintText: 'Your Name',
                ),
                SizedBox(
                  height: mq.height * 0.02,
                ),
                CustomTextField(
                  readonly: true,
                  hintText: 'Man',
                ),
                SizedBox(
                  height: mq.height * 0.02,
                ),
                CustomTextField(
                  readonly: true,
                  hintText: 'Phone Number',
                ),
              ],
            ),
          ),
          SizedBox(
            height: mq.height * 0.01,
          ),
          const ListTile(
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
            leading: Icon(Icons.info),
            title: Text('Privacy Policy'),
          ),
          const ListTile(
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
            leading: Icon(Icons.dehaze),
            title: Text('Terms and Condition'),
          )
        ],
      ),
    );
  }
}
