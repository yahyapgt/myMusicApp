import 'package:flutter/material.dart';
import 'package:music_project/Screens/playingNow/player_widget.dart';
import 'package:music_project/constans/color.dart';

import 'package:music_project/controller/controls.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    super.key,
    required this.songModel,
    this.count = 0,
  });
  final List<SongModel> songModel;
  final int count;
  // final AudioPlayer audioPlayer;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  int large = 0;
  int currentIndex = 0;
  bool firstSong = false;
  bool lastSong = false;

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          GetAllSongController.currentIndexes = index;
          if (mounted) {
            setState(
              () {
                large = widget.count - 1;
                currentIndex = index;
                index == 0 ? firstSong = true : firstSong = false;
                index == large ? lastSong = true : lastSong = false;
              },
            );
          }
        }
      },
    );
    super.initState();
    playSong();
  }

  void playSong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen(
      (d) {
        setState(
          () {
            _duration = d!;
          },
        );
      },
    );
    GetAllSongController.audioPlayer.positionStream.listen(
      (p) {
        setState(
          () {
            _position = p;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              bottomSheetForNowPlaying(context);
              
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        title: Text(
          'Playing Now',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            color: primaryColor,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 260,
                width: 290,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: PhysicalModel(
                    color: Colors.transparent,
                    shadowColor: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      color: Colors.transparent,
                      child: QueryArtworkWidget(
                        id: widget.songModel[currentIndex].id,
                        type: ArtworkType.AUDIO,
                        keepOldArtwork: true,
                        artworkBorder: BorderRadius.circular(10),
                        artworkHeight:
                            MediaQuery.of(context).size.width * 1 / 2,
                        artworkWidth: MediaQuery.of(context).size.width * 1 / 2,
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: SizedBox(
                          height: MediaQuery.of(context).size.width * 1 / 2,
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          child: const Icon(Icons.music_note,
                              size: 90,
                              color: Color.fromARGB(255, 240, 121, 0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
// title
                      child: TextScroll(
                        widget.songModel[currentIndex].displayNameWOExt,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                        mode: TextScrollMode.endless,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Center(
// artist name

                      child: Text(
                        widget.songModel[currentIndex].artist.toString() ==
                                '<unknown>'
                            ? "Unknown Artist"
                            : widget.songModel[currentIndex].artist.toString(),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

// position and duraton

              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        _formatDuration(_position),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 28),
                      child: Text(
                        _formatDuration(_duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // slider .....

              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.transparent,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 7,
                      elevation: 5,
                      pressedElevation: 5,
                    ),
                  ),
                  child: Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white38,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(
                        () {
                          changeToSeconds(
                            value.toInt(),
                          );
                          value = value;
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              PlayingControls(
                count: widget.count,
                lastSong: lastSong,
                firstSong: firstSong,
                favsongmodel: widget.songModel[currentIndex],
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return "$minutes:$seconds";
    }
  }
}
