// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:music_project/Screens/Home/homepage.dart';
// import 'package:music_project/Screens/Home/miniplayer.dart';
// import 'package:music_project/controller/controls.dart';
// import 'package:music_project/db/Model/recently_db.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class BottomNav extends StatelessWidget {
//   const BottomNav({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           GetAllSongController.audioPlayer.currentIndex != null
//               ? ValueListenableBuilder(
//                   valueListenable: GetRecentlyPlayed.recentSongNotifier,
//                   builder: (context, list, child) {
//                     if (list.isNotEmpty) {
//                       MiniPlayer();
//                     } else {
//                       Container();
//                     }
//                     return MiniPlayer();
//                   })
//               : Container()
//         ],
//       ),
//       body: HomeScreen(),
//     );
//   }
// }
