import 'package:flutter/material.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/db/Model/model_db.dart';
import 'package:music_project/db/Model/playlistdb.dart';

import 'package:on_audio_query/on_audio_query.dart';

class PlaylistAddSong extends StatefulWidget {
  const PlaylistAddSong({super.key, required this.playlist});
  final MusicPlayer playlist;
  @override
  State<PlaylistAddSong> createState() => _PlaylistAddSongState();
}

class _PlaylistAddSongState extends State<PlaylistAddSong> {
  bool isPlaying = true;
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Add songs",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('No songs availble'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/icons8-music-64.png'),
                  ),
                  title: Text(
                    item.data![index].displayNameWOExt,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    item.data![index].artist.toString(),
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: SizedBox(
                    height: 60,
                    width: 60,
                    child: Container(
                      child: !widget.playlist.isValueIn(item.data![index].id)
                          ? IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    songAddToPlaylist(
                                      item.data![index],
                                    );
                                    PlaylistDB.playlistNotifier
                                        .notifyListeners();
                                  },
                                );
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    songDeleteFromPlaylist(item.data![index]);
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.amber,
                              ),
                            ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }

  void songAddToPlaylist(SongModel data) {
    widget.playlist.add(data.id);

    final addedToPlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: const Text(
        'Song added to playlist',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(addedToPlaylist);
  }

  void songDeleteFromPlaylist(SongModel data) {
    widget.playlist.deleteData(data.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song removed from Playlist',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }
}
