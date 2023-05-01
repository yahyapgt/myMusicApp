import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:music_project/Screens/splashScreen/splash.dart';
import 'package:music_project/db/Model/model_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(MusicPlayerAdapter().typeId)) {
    Hive.registerAdapter(MusicPlayerAdapter());
  }


  await Hive.initFlutter();
  await Hive.openBox<int>("FavoriteDb");
  await Hive.openBox<MusicPlayer>('playlistDb');
  
  
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
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
