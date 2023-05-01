import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_project/Screens/allSongs/allsongs.dart';
import 'package:music_project/Screens/playingNow/nowplaying.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/model_db.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'playlist_add_song.dart';

class ScreenPlaylist extends StatelessWidget {
  const ScreenPlaylist({
    super.key,
    required this.playlist,
    required this.findex,
    this.image,
  });
  final MusicPlayer playlist;
  final int findex;
  // ignore: prefer_typing_uninitialized_variables
  final image;

  @override
  Widget build(BuildContext context) {
    late List<SongModel> songPlaylist;
    return ValueListenableBuilder(
      valueListenable: Hive.box<MusicPlayer>('playlistDb').listenable(),
      builder: (BuildContext context, Box<MusicPlayer> music, Widget? child) {
        songPlaylist = listPlaylist(music.values.toList()[findex].songId);
        // debugPrint("yahiya kundan ${songPlaylist}");
        return Scaffold(
          backgroundColor: primaryColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
//pop button
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
// Add song
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistAddSong(
                            playlist: playlist,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
//Title
                  title: Text(
                    playlist.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  expandedTitleScale: 1.6,
                  background: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),

                expandedHeight: MediaQuery.of(context).size.width * 2.5 / 4,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    songPlaylist.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlaylistAddSong(
                                          playlist: playlist,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.add_box,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                                const Center(
                                  child: Text(
                                    'Add Songs To Your playlist',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: ListTile(
                                  leading:  QueryArtworkWidget(id: songPlaylist[index].id, type: ArtworkType.AUDIO,artworkBorder: BorderRadius.circular(40),),
                                  title: Text(
                                    songPlaylist[index].displayNameWOExt,
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    songPlaylist[index].artist.toString(),
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: IconButton(
                                      icon: const Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: () {
                                        songDeleteFromPlaylist(
                                            songPlaylist[index], context);
                                      },
                                    ),
                                  ),
                                  onTap: () {
                                    GetAllSongController.audioPlayer
                                        .setAudioSource(
                                            GetAllSongController.createSongList(
                                                songPlaylist),
                                            initialIndex: index);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NowPlaying(
                                          songModel: songPlaylist,
                                          count: songPlaylist.length,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: songPlaylist.length,
                          )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void songDeleteFromPlaylist(SongModel data, context) {
    playlist.deleteData(data.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song removed from Playlist',
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < StartSongs.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (StartSongs[i].id == data[j]) {
          plsongs.add(StartSongs[i]);
        }
      }
    }

    return plsongs;
  }
}
