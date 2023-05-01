import 'package:flutter/material.dart';
import 'package:music_project/Screens/settings/settingscreen.dart';

const primaryColor = Color.fromARGB(255, 6, 17, 38);
var sbox = SizedBox(
  height: 20,
);

Widget sbox2({required double sheight}) {
  return SizedBox(
    height: sheight,
  );
}

Widget text_privacy_policy(String _text) {
  return Text(
    _text,
    style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.white,
        fontSize: 12),
  );
}

Widget text_privacy_policy2(String _text2, double _textsize) {
  return Text(
    _text2,
    style: TextStyle(
        color: Colors.white,
        fontSize: _textsize,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold),
  );
}

void bottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      color: Colors.black,
      height: 120,
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            title: const Text(
              'Like',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.playlist_add_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Add to playlist',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}

void bottomSheetForNowPlaying(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      color: Colors.black,
      height: 70,
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettinsPage(),
                  ));
            },
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}
