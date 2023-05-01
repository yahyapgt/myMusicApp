import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/favouriteDb.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingControls extends StatefulWidget {
  const PlayingControls(
      {super.key,
      required this.count,
      required this.lastSong,
      required this.firstSong,
      required this.favsongmodel});

  final int count;
  final bool firstSong;
  final bool lastSong;
  final SongModel favsongmodel;

  @override
  State<PlayingControls> createState() => _PlayingControlsState();
}

class _PlayingControlsState extends State<PlayingControls> {
  bool isPlaying = true;

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // add playlist button
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.playlist_add,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 15,
            ),

            // fav button
            ValueListenableBuilder(
              valueListenable: FavoriteDb.favoriteSongs,
              builder: (context, List<SongModel> favoriteSongs, child) {
                return IconButton(
                    onPressed: () {
                      if (FavoriteDb.isFavor(widget.favsongmodel)) {
                        FavoriteDb.delete(
                          widget.favsongmodel.id,
                        );

                        final remove = ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 17, 0),
                                content: Text("UnLiked")));
                      } else {
                        FavoriteDb.add(widget.favsongmodel);
                        final remove = ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                backgroundColor: Color.fromARGB(255, 0, 255, 8),
                                content: Text("LIKED")));
                      }
                      FavoriteDb.favoriteSongs.notifyListeners();
                    },
                    icon: FavoriteDb.isFavor(widget.favsongmodel)
                        ? Icon(
                            Icons.favorite,
                            size: 30,
                            color: Color.fromARGB(255, 0, 255, 26),
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ));
              },
            ),
            const SizedBox(
              width: 15,
            ),

            // repeat button
            IconButton(
              onPressed: () {
                GetAllSongController.audioPlayer.loopMode == LoopMode.one
                    ? GetAllSongController.audioPlayer.setLoopMode(LoopMode.all)
                    : GetAllSongController.audioPlayer
                        .setLoopMode(LoopMode.one);
              },
              icon: StreamBuilder<LoopMode>(
                stream: GetAllSongController.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopMode = snapshot.data;
                  if (LoopMode.one == loopMode) {
                    return const Icon(
                      Icons.repeat,
                      size: 30,
                      color: Colors.blue,
                    );
                  } else {
                    return const Icon(
                      Icons.repeat,
                      color: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
// skip previous
            widget.firstSong
                ? Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.skip_previous,
                          color: Colors.white30,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (GetAllSongController.audioPlayer.hasPrevious) {
                            GetAllSongController.audioPlayer.seekToPrevious();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Color.fromARGB(255, 250, 249, 249),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
// play pause
            Center(
              child: IconButton(
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        if (GetAllSongController.audioPlayer.playing) {
                          GetAllSongController.audioPlayer.pause();
                        } else {
                          GetAllSongController.audioPlayer.play();
                        }
                        isPlaying = !isPlaying;
                      });
                    }
                  },
                  icon: isPlaying
                      ? const Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 50,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        )),
            ),
// skip next
            widget.lastSong
                ? Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.white30,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (GetAllSongController.audioPlayer.hasNext) {
                            GetAllSongController.audioPlayer.seekToNext();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  )
          ],
        )
      ],
    );
  }
}
