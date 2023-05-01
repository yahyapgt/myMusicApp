import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_project/Screens/allSongs/allsongs.dart';
import 'package:music_project/Screens/likedSong/likedsongs.dart';
import 'package:music_project/Screens/mostlyPlayed/mostlyplayed.dart';
import 'package:music_project/Screens/playingNow/nowplaying.dart';
import 'package:music_project/Screens/playlist/playlist_pade_screen.dart';
import 'package:music_project/Screens/playlist/songstoplaylist.dart';

import 'package:music_project/Screens/recentlyPlayed/recentlyplayed.dart';
import 'package:music_project/Screens/searchScreen/searchscreen.dart';
import 'package:music_project/Screens/settings/settingscreen.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/constans/images/images.dart';
import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/favouriteDb.dart';
import 'package:music_project/db/Model/mostly_db.dart';
import 'package:music_project/db/Model/recently_db.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_scroll/text_scroll.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstSong = false;

  bool isPlaying = false;
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null && mounted) {
          setState(
            () {
              index == 0 ? firstSong = true : firstSong = false;
            },
          );
        }
      },
    );
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  
  void requestPermission() async {
    dynamic perm = await _audioQuery.permissionsStatus();
    if (!perm) {
      await _audioQuery.permissionsRequest();
    }
  }


  final _audioQuery = new OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: Color(0xff061126),
        ),
        drawer: Drawer(
          backgroundColor: primaryColor.withOpacity(0.75),
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  )),
              SizedBox(
                height: 100,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LikedSong(),
                      ));
                },
                leading: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
                title: Text(
                  'Liked Songs',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MostlyPlayed(),
                      ));
                },
                leading: Icon(
                  Icons.history_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  'Mostly Played',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecentlyPlayed(),
                      ));
                },
                leading: Icon(
                  Icons.featured_play_list,
                  color: Colors.grey,
                ),
                title: Text(
                  'Recently Played',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistPage(),
                      ));
                },
                leading: Icon(
                  Icons.playlist_play,
                  color: Colors.grey,
                ),
                title: Text(
                  'Playlist',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
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
                  color: Colors.grey,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.90,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 18),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllSongs(),
                        ));
                  },
                  child: const Text(
                    'All Songs',
                    style: TextStyle(
                      color: Color(0xffeaf0ff),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              SizedBox(
                height: 250,
                child: FutureBuilder<List<SongModel>>(
                  future: _audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                  ),
                  builder: (context, item) {
                  
                    ////  final  song= item.data!;
                    if (item.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (item.data!.isEmpty) {
                      return const Center(
                        child: Text('No Songs Found'),
                      );
                    }
                    if (!FavoriteDb.isInitialized) {
                      FavoriteDb.initialize(item.data!);
                    }

                  if(item.data==null){
                      StartSongs = item.data!;
                  }

                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  GetMostlyPlayedController.addMostlyPlayed(
                                      item.data![index].id);

                                  GetRecentlyPlayed.addRecentlyPlayed(
                                      item.data![index].id);

                                  GetAllSongController.audioPlayer
                                      .setAudioSource(
                                    GetAllSongController.createSongList(
                                        item.data!),
                                    initialIndex: index,
                                  );

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return NowPlaying(
                                        songModel: item.data!,
                                        count: item.data!.length);
                                  }));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  height: height.size.height * .28,
                                  width: height.size.width * .46,
                                  child: Stack(
                                    children: [
                                      Container(
                                        color: primaryColor,
                                        height: 179,
                                        width: double.infinity,
                                        child: QueryArtworkWidget(
                                            artworkBorder:
                                                BorderRadius.horizontal(),
                                            id: item.data![index].id,
                                            type: ArtworkType.AUDIO,
                                            artworkFit: BoxFit.cover,
                                            nullArtworkWidget: Image.asset(
                                                "assets/images/chaff&dust.png")),
                                      ),
                                      Positioned(
                                        top: 185,
                                        left: 10,
                                        child: Text(
                                          item.data![index].displayNameWOExt,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w100),
                                        ),
                                      ),
                                      Positioned(
                                        left: 145,
                                        bottom: 165,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) => Container(
                                                color: Colors.black,
                                                height: 120,
                                                width: double.infinity,
                                                child: ValueListenableBuilder(
                                                    valueListenable: FavoriteDb
                                                        .favoriteSongs,
                                                    builder: (context,
                                                        List<SongModel>
                                                            favoriteSongs,
                                                        child) {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            onTap: () {
                                                              if (FavoriteDb
                                                                  .isFavor(item
                                                                          .data![
                                                                      index])) {
                                                                FavoriteDb
                                                                    .delete(
                                                                  item
                                                                      .data![
                                                                          index]
                                                                      .id,
                                                                );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

                                                                final remove = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            17,
                                                                            0),
                                                                    content: Text(
                                                                        "UnLiked")));
                                                              } else {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                FavoriteDb.add(
                                                                    item.data![
                                                                        index]);
                                                                final remove = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            255,
                                                                            8),
                                                                    content: Text(
                                                                        "LIKED")));
                                                              }
                                                              FavoriteDb
                                                                  .favoriteSongs
                                                                  .notifyListeners();
                                                            },
                                                            leading: FavoriteDb
                                                                    .isFavor(item
                                                                            .data![
                                                                        index])
                                                                ? Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            85,
                                                                            255,
                                                                            0),
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                  ),
                                                            title: FavoriteDb
                                                                    .isFavor(item
                                                                            .data![
                                                                        index])
                                                                ? Text(
                                                                    'Liked',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )
                                                                : Text(
                                                                    'Like',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                          ),
                                                          ListTile(
                                                            onTap: () {},
                                                            leading: Icon(
                                                              Icons
                                                                  .playlist_add_outlined,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            title: InkWell(
                                                              onTap: () {
                                                                playlistDialogue(
                                                                    context,
                                                                    item.data![
                                                                        index]);
                                                              },
                                                              child: const Text(
                                                                'Add to playlist',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 15,
                            ),
                        itemCount: item.data!.length);
                  },
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistPage(),
                        ));
                  },
                  child: const Text(
                    'My Playlist',
                    style: TextStyle(
                      color: Color(0xffeaf0ff),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 195,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllSongs(),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              height: height.size.height * .24,
                              width: height.size.width * .45,
                              child: Stack(
                                children: [
                                  Container(
                                    color: primaryColor,
                                    height: 159,
                                    width: double.infinity,
                                    child: Image(
                                      image: AssetImage(playPhotos[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 160,
                                    left: 12,
                                    child: Text(
                                        playlisttName[index].toUpperCase(),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  // Positioned(
                                  //   left: 145,
                                  //   bottom: 144,
                                  //   child: IconButton(
                                  //     icon: const Icon(
                                  //       Icons.more_vert,
                                  //       color: Colors.white,
                                  //       size: 30,
                                  //     ),
                                  //     onPressed: () {
                                  //       bottomSheet(context);
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                    itemCount: 9),
              ),
              SizedBox(
                height: 35,
              ),
              ValueListenableBuilder(
                  valueListenable: GetRecentlyPlayed.recentSongNotifier,
                  builder: (context, List<SongModel> item, Widget? child) {
                    return item.isEmpty
                        ? SizedBox()
                        : Container(
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey)),
                            height: 58,
                            width: double.infinity,
                            child: Column(
                              children: [
                                // Slider(
                                //   value: 0.0,
                                //   onChanged: (value) {},
                                // ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => NowPlaying(
                                                  songModel:
                                                      GetAllSongController
                                                          .playingsong,
                                                  count: GetAllSongController
                                                      .playingsong.length,
                                                )));
                                  },
                                  leading: QueryArtworkWidget(
                                      artworkBorder: BorderRadius.horizontal(),
                                      id: GetAllSongController
                                          .playingsong[GetAllSongController
                                              .currentIndexes]
                                          .id,
                                      type: ArtworkType.AUDIO),
                                  title: StreamBuilder<bool>(
                                      stream: GetAllSongController
                                          .audioPlayer.playingStream,
                                      builder: (context, item) {
                                        bool? play = item.data!;
                                        return play != null && play
                                            ? TextScroll(
                                                GetAllSongController
                                                    .playingsong[
                                                        GetAllSongController
                                                            .currentIndexes]
                                                    .displayNameWOExt,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : TextScroll(
                                                GetAllSongController
                                                    .playingsong[
                                                        GetAllSongController
                                                            .currentIndexes]
                                                    .displayNameWOExt,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              );
                                      }),
                                  // subtitle: Text(
                                  //   'HYONNA',
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          GetAllSongController.addRecentlyPlayed(
                                              GetAllSongController
                                                  .playingsong[
                                                      GetAllSongController
                                                              .audioPlayer
                                                              .currentIndex! -
                                                          1]
                                                  .id);
                                          if (GetAllSongController
                                              .audioPlayer.hasPrevious) {
                                            GetAllSongController.audioPlayer
                                                .seekToPrevious();
                                            await GetAllSongController
                                                .audioPlayer
                                                .play();
                                          } else {
                                            await GetAllSongController
                                                .audioPlayer
                                                .play();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.skip_previous,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          if (GetAllSongController
                                              .audioPlayer.playing) {
                                            await GetAllSongController
                                                .audioPlayer
                                                .pause();
                                            setState(() {
                                              isPlaying = !isPlaying;
                                            });
                                          } else {
                                            await GetAllSongController
                                                .audioPlayer
                                                .play();
                                            setState(() {
                                              isPlaying = !isPlaying;
                                            });
                                          }
                                        },
                                        icon: StreamBuilder<bool>(
                                            stream: GetAllSongController
                                                .audioPlayer.playingStream,
                                            builder: (context, snapshot) {
                                              bool? played = snapshot.data;
                                              return played != null && played
                                                  ? Icon(
                                                      Icons.pause,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )
                                                  : Icon(
                                                      Icons.play_arrow_outlined,
                                                      color: Colors.white,
                                                    );
                                            }),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          GetRecentlyPlayed.addRecentlyPlayed(
                                              GetAllSongController
                                                  .playingsong[
                                                      GetAllSongController
                                                              .audioPlayer
                                                              .currentIndex! +
                                                          1]
                                                  .id);
                                          if (GetAllSongController
                                              .audioPlayer.hasNext) {
                                            await GetAllSongController
                                                .audioPlayer
                                                .seekToNext();
                                            await GetAllSongController
                                                .audioPlayer
                                                .play();
                                          } else {
                                            await GetAllSongController
                                                .audioPlayer
                                                .play();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.skip_next,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
