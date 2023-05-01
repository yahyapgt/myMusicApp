// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:music_project/Screens/playingNow/nowplaying.dart';
// import 'package:music_project/controller/controls.dart';
// import 'package:music_project/db/Model/recently_db.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:text_scroll/text_scroll.dart';

// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({super.key});

//   @override
//   State<MiniPlayer> createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer> {
//    bool firstSong = false;

//   bool isPlaying = false;
//   void initState() {
//     GetAllSongController.audioPlayer.currentIndexStream.listen(
//       (index) {
//         if (index != null && mounted) {
//           setState(
//             () {
//               index == 0 ? firstSong = true : firstSong = false;
//             },
//           );
//         }
//       },
//     );
//     // TODO: implement initState
//    super.initState();
//   } 
    
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: GetRecentlyPlayed.recentSongNotifier,
//         builder: (context, List<SongModel> item, Widget? child) {
//           return item.isEmpty
//               ? SizedBox()
//               : Container(
//                   margin: EdgeInsets.only(right: 15),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 0.5, color: Colors.grey)),
//                   height: 58,
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       // Slider(
//                       //   value: 0.0,
//                       //   onChanged: (value) {},
//                       // ),
//                       ListTile(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => NowPlaying(
//                                     songModel: GetAllSongController.playingsong,
//                                     count:
//                                         GetAllSongController.playingsong.length,
//                                   )));
//                         },
//                         leading: QueryArtworkWidget(
//                             artworkBorder: BorderRadius.horizontal(),
//                             id: GetAllSongController
//                                 .playingsong[
//                                     GetAllSongController.currentIndexes]
//                                 .id,
//                             type: ArtworkType.AUDIO),
//                         title: StreamBuilder<bool>(
//                             stream:
//                                 GetAllSongController.audioPlayer.playingStream,
//                             builder: (context, item) {
//                               bool? play = item.data!;
//                               return play != null && play
//                                   ? TextScroll(
//                                       GetAllSongController
//                                           .playingsong[GetAllSongController
//                                               .currentIndexes]
//                                           .displayNameWOExt,
//                                       style: TextStyle(color: Colors.white),
//                                     )
//                                   : TextScroll(
//                                       GetAllSongController
//                                           .playingsong[GetAllSongController
//                                               .currentIndexes]
//                                           .displayNameWOExt,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     );
//                             }),
//                         // subtitle: Text(
//                         //   'HYONNA',
//                         //   style: TextStyle(color: Colors.white),
//                         // ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               onPressed: () async {
//                                 GetAllSongController.addRecentlyPlayed(
//                                     GetAllSongController
//                                         .playingsong[GetAllSongController
//                                                 .audioPlayer.currentIndex! -
//                                             1]
//                                         .id);
//                                 if (GetAllSongController
//                                     .audioPlayer.hasPrevious) {
//                                   GetAllSongController.audioPlayer
//                                       .seekToPrevious();
//                                   await GetAllSongController.audioPlayer.play();
//                                 } else {
//                                   await GetAllSongController.audioPlayer.play();
//                                 }
//                               },
//                               icon: Icon(
//                                 Icons.skip_previous,
//                                 size: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () async {
//                                 if (GetAllSongController.audioPlayer.playing) {
//                                   await GetAllSongController.audioPlayer
//                                       .pause();
//                                   setState(() {
//                                     isPlaying = !isPlaying;
//                                   });
//                                 } else {
//                                   await GetAllSongController.audioPlayer.play();
//                                   setState(() {
//                                     isPlaying = !isPlaying;
//                                   });
//                                 }
//                               },
//                               icon: StreamBuilder<bool>(
//                                   stream: GetAllSongController
//                                       .audioPlayer.playingStream,
//                                   builder: (context, snapshot) {
//                                     bool? played = snapshot.data;
//                                     return played != null && played
//                                         ? Icon(
//                                             Icons.pause,
//                                             size: 20,
//                                             color: Colors.white,
//                                           )
//                                         : Icon(
//                                             Icons.play_arrow_outlined,
//                                             color: Colors.white,
//                                           );
//                                   }),
//                             ),
//                             IconButton(
//                               onPressed: () async {
//                                 GetRecentlyPlayed.addRecentlyPlayed(
//                                     GetAllSongController
//                                         .playingsong[GetAllSongController
//                                                 .audioPlayer.currentIndex! +
//                                             1]
//                                         .id);
//                                 if (GetAllSongController.audioPlayer.hasNext) {
//                                   await GetAllSongController.audioPlayer
//                                       .seekToNext();
//                                   await GetAllSongController.audioPlayer.play();
//                                 } else {
//                                   await GetAllSongController.audioPlayer.play();
//                                 }
//                               },
//                               icon: Icon(
//                                 Icons.skip_next,
//                                 size: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//         });
//   }
// }
