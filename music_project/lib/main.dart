import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_project/Screens/Home/homepage.dart';
import 'package:music_project/Screens/aboutScreen/about.dart';
import 'package:music_project/Screens/allSongs/allsongs.dart';
import 'package:music_project/Screens/likedSong/likedsongs.dart';
import 'package:music_project/Screens/mostlyPlayed/mostlyplayed.dart';
import 'package:music_project/Screens/playingNow/playingnow.dart';
import 'package:music_project/Screens/playlist/playlist.dart';
import 'package:music_project/Screens/recentlyPlayed/recentlyplayed.dart';
import 'package:music_project/Screens/searchScreen/searchscreen.dart';
import 'package:music_project/Screens/settings/settingscreen.dart';
import 'package:music_project/Screens/splashScreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true, fontFamily: GoogleFonts.inder().fontFamily),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen()
        //HomeScreen(),
        );
  }
}