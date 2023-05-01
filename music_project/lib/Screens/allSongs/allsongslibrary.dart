import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_project/Screens/playingNow/nowplaying.dart';
import 'package:music_project/Screens/playlist/songstoplaylist.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/favouriteDb.dart';
import 'package:music_project/db/Model/mostly_db.dart';
import 'package:music_project/db/Model/recently_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllsongControll extends StatelessWidget {
  AllsongControll({super.key, required this.itemsongs});

  List<SongModel> itemsongs;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: itemsongs.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              GetMostlyPlayedController.addMostlyPlayed(itemsongs[index].id);

              GetRecentlyPlayed.addRecentlyPlayed(itemsongs[index].id);

              GetAllSongController.audioPlayer.setAudioSource(
                GetAllSongController.createSongList(itemsongs),
                initialIndex: index,
              );

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NowPlaying(
                  songModel: itemsongs,
                  count: itemsongs.length,
                );
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Color.fromARGB(255, 86, 83, 83),
                    ),
                    // image: DecorationImage(image: AssetImage(photos[index])),
                    borderRadius: BorderRadius.circular(9),
                    color: primaryColor),
                margin: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                      color: primaryColor,
                      height: 147,
                      width: double.infinity,
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.horizontal(),
                        id: itemsongs[index].id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                       nullArtworkWidget: Image.asset(
                                                "assets/images/chaff&dust.png"),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 7,
                      child: Text(
                        itemsongs[index].displayNameWOExt,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 135,
                      bottom: 125,
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
                                  valueListenable: FavoriteDb.favoriteSongs,
                                  builder: (context,
                                      List<SongModel> favoriteSongs, child) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            if (FavoriteDb.isFavor(
                                                itemsongs[index])) {
                                              FavoriteDb.delete(
                                                itemsongs[index].id,
                                              );
                                              Navigator.of(context).pop();

                                              final remove =
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  17,
                                                                  0),
                                                          content:
                                                              Text("UnLiked")));
                                            } else {
                                              Navigator.of(context).pop();
                                              FavoriteDb.add(itemsongs[index]);
                                              final remove =
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  255,
                                                                  8),
                                                          content:
                                                              Text("LIKED")));
                                            }
                                            FavoriteDb.favoriteSongs
                                                .notifyListeners();
                                          },
                                          leading: FavoriteDb.isFavor(
                                                  itemsongs[index])
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Color.fromARGB(
                                                      255, 85, 255, 0),
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                          title: FavoriteDb.isFavor(
                                                  itemsongs[index])
                                              ? Text(
                                                  'Liked',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : Text(
                                                  'Like',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          leading: Icon(
                                            Icons.playlist_add_outlined,
                                            color: Colors.white,
                                          ),
                                          title: InkWell(
                                            onTap: () {
                                              playlistDialogue(
                                                  context, itemsongs[index]);
                                            },
                                            child: const Text(
                                              'Add to playlist',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
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
          );
        },
      ),
    );
  }
}
