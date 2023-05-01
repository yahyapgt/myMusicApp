import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_project/Screens/allSongs/allsongslibrary.dart';
import 'package:music_project/Screens/playingNow/nowplaying.dart';

import 'package:music_project/constans/color.dart';

import 'package:music_project/controller/controls.dart';
import 'package:music_project/db/Model/favouriteDb.dart';
import 'package:music_project/db/Model/mostly_db.dart';
import 'package:music_project/db/Model/recently_db.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

List<SongModel> StartSongs = [];

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  @override
  void initState() {
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

  playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(uri!),
      ));
      _audioPlayer.play();
    } on Exception {
      log("Error Parsing Song" as num);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff061126),
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
                    'All Songs',
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
            child: FutureBuilder<List<SongModel>>(
              future: _audioQuery.querySongs(
                sortType: null,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true,
              ),
              builder: (context, item) {
                final song = item.data;

                if (item.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (item.data!.isEmpty) {
                  return Center(
                    child: Text('No Songs Found'),
                  );
                }
                if (!FavoriteDb.isInitialized) {
                  FavoriteDb.initialize(item.data!);
                }
                StartSongs = item.data!;

              return  AllsongControll(
                  itemsongs: item.data!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
