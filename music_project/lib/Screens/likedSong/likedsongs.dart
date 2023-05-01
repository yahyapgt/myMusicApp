import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_project/Screens/playingNow/nowplaying.dart';
import 'package:music_project/constans/color.dart';

import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/favouriteDb.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSong extends StatelessWidget {
  const LikedSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff061126),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.navigate_before,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Color(0xff061126),
      ),
      body: Column(
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
                    'Liked Songs',
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
            child: ValueListenableBuilder(
                valueListenable: FavoriteDb.favoriteSongs,
                builder:
                    (context, List<SongModel> favoritedata, Widget? child) {
                  return GridView.builder(
                    itemCount: favoritedata.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                        GetAllSongController.audioPlayer
                                      .setAudioSource(
                                    GetAllSongController.createSongList(
                                        favoritedata),
                                    initialIndex: index,
                                  );




                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    NowPlaying(songModel: favoritedata,count: favoritedata.length,)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
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
                                    id: favoritedata[index].id,
                                    type: ArtworkType.AUDIO,
                                    keepOldArtwork: true,
                                    artworkBorder: BorderRadius.circular(10),
                                    artworkHeight:
                                        MediaQuery.of(context).size.width *
                                            1 /
                                            2,
                                    artworkWidth:
                                        MediaQuery.of(context).size.width *
                                            1 /
                                            2,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1 /
                                              2,
                                      width: MediaQuery.of(context).size.width *
                                          1 /
                                          2,
                                      child: const Icon(Icons.music_note,
                                          size: 90,
                                          color:
                                              Color.fromARGB(255, 240, 121, 0)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 150,
                                  left: 7,
                                  child: Text(
                                    favoritedata[index].displayNameWOExt,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                                Positioned(
                                  left: 125,
                                  bottom: 125,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(255, 98, 255, 0),
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      FavoriteDb.favoriteSongs
                                          .notifyListeners();
                                      FavoriteDb.delete(favoritedata[index].id);
                                      final remove =
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text("REMOVED")));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
