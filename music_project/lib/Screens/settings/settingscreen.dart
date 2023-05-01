import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_project/Screens/aboutScreen/about.dart';
import 'package:music_project/Screens/likedSong/likedsongs.dart';
import 'package:music_project/Screens/privacyPolicy/privacy.dart';
import 'package:music_project/Screens/tearms&condition/tearmscondition.dart';
import 'package:music_project/constans/color.dart';

class SettinsPage extends StatefulWidget {
  const SettinsPage({super.key});

  @override
  State<SettinsPage> createState() => _SettinsPageState();
}

class _SettinsPageState extends State<SettinsPage> {
  bool valNotifyl = false;

  bool valNotify2 = true;

  bool valNotifyl3 = true;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotifyl = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotifyl3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor.withOpacity(0.9),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Privacy',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            buildAccountOption(context, 'About', AboutScreen()),
            buildAccountOption(context, 'Terms & Conditions', TermsScreen()),
            buildAccountOption(
                context, 'Privacy and Secuirity', PrivacyScreen()),
            SizedBox(
              height: 90,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Notification',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOption(
                "Notification", valNotifyl, onChangeFunction1),
            buildNotificationOption(
                "Theme Dark", valNotify2, onChangeFunction2),
            buildNotificationOption(
                "Account Active", valNotifyl3, onChangeFunction3),
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              activeColor: Colors.blue,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(
      BuildContext context, String title, var nav) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => nav,
        ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
