import 'package:flutter/material.dart';
import 'package:music_project/Screens/playingNow/nowplaying.dart';
import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/mostly_db.dart';
import 'package:music_project/db/Model/recently_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../constans/color.dart';


class MostlyPlayed extends StatefulWidget {
  const MostlyPlayed({super.key});

  @override
  State<MostlyPlayed> createState() => _MostlyPlayedState();
}

class _MostlyPlayedState extends State<MostlyPlayed> {
  List<SongModel> Mostly = [];

  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future initialize() async {
    await GetMostlyPlayedController.getMostlyplayed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          'Mostly Played',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
          future: GetMostlyPlayedController.getMostlyplayed(),
          builder: (context, snapshot) {
            return ValueListenableBuilder(
                valueListenable: GetMostlyPlayedController.mostlyPlayedNotifier,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 350, left: 100),
                      child: Text(
                        "Your Mostly Is Empty",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(147, 255, 255, 255)),
                      ),
                    );
                  } else {
                    final temp = value.reversed.toList();
                    Mostly = temp.toSet().toList();

                    return FutureBuilder<List<SongModel>>(
                        future: _audioQuery.querySongs(
                            sortType: null,
                            orderType: OrderType.ASC_OR_SMALLER,
                            uriType: UriType.EXTERNAL,
                            ignoreCase: true),
                        builder: (context, item) {
                          if (item.data == null) {
                            const CircularProgressIndicator();
                          } else if (item.data!.isEmpty) {
                            return const Center(
                              child: Text('No songs in your internal'),
                            );
                          }

                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 23,
                                      ),
                                      Text(
                                        'Mostly Played Songs',
                                        style: TextStyle(
                                          color: Color(0xffeaf0ff),
                                          fontSize: 23,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: GridView.builder(
                                  itemCount: Mostly.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.white,
                                            ),
                                            // image: DecorationImage(image: AssetImage(photos[index])),
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color: primaryColor),
                                        margin: EdgeInsets.all(10),
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                GetAllSongController.audioPlayer
                                                    .setAudioSource(
                                                  GetAllSongController
                                                      .createSongList(
                                                          item.data!),
                                                  initialIndex: index,
                                                );

                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NowPlaying(
                                                              songModel: Mostly,
                                                              count:
                                                                  Mostly.length,
                                                            )));
                                              },
                                              child: Container(
                                                color: primaryColor,
                                                height: 147,
                                                width: double.infinity,
                                                child: QueryArtworkWidget(
                                                  id: Mostly[index].id,
                                                  type: ArtworkType.AUDIO,
                                                  keepOldArtwork: true,
                                                  artworkBorder:
                                                      BorderRadius.circular(10),
                                                  artworkHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          1 /
                                                          2,
                                                  artworkWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          1 /
                                                          2,
                                                  artworkFit: BoxFit.cover,
                                                  nullArtworkWidget: Image.asset(
                                                "assets/images/chaff&dust.png"),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 150,
                                              left: 7,
                                              child: Text(
                                                Mostly[index].displayNameWOExt,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                            ),
                                            // Positioned(
                                            //   left: 135,
                                            //   bottom: 125,
                                            //   child: IconButton(
                                            //     icon: const Icon(
                                            //       Icons.more_vert,
                                            //       color: Colors.white,
                                            //       size: 30,
                                            //     ),
                                            //     onPressed: () {},
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        });
                  }
                });
          }),
    );
  }
}
