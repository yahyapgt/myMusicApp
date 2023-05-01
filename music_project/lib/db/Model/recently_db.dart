import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_project/Screens/allSongs/allsongs.dart';
import 'package:music_project/db/Model/model_db.dart';

import 'package:on_audio_query/on_audio_query.dart';

class GetRecentlyPlayed {
  static ValueNotifier<List<SongModel>> recentSongNotifier = ValueNotifier([]);
  static List recentlyplayed = [];

  static Future<void> addRecentlyPlayed(Songid) async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    await recentDB.add(Songid);
    getRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> getRecentlySongs() async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    // recentlyplayed = await recentDB.values.toList();
    displayRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> displayRecentlySongs() async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    final recentSongItems = recentDB.values.toList();
    recentSongNotifier.value.clear();
    recentlyplayed.clear();
    for (int i = 0; i < recentSongItems.length; i++) {
      for (int j = 0; j < StartSongs.length; j++) {
        if (recentSongItems[i] == StartSongs[j].id) {
          recentSongNotifier.value.add(StartSongs[j]);
          recentlyplayed.add(StartSongs[j]);
        }
      }
    }
  }
}


