import 'package:flutter/material.dart';
import 'package:music_project/Screens/allSongs/allsongs.dart';
import 'package:music_project/Screens/likedSong/likedsongs.dart';
import 'package:music_project/Screens/mostlyPlayed/mostlyplayed.dart';
import 'package:music_project/Screens/playingNow/playingnow.dart';
import 'package:music_project/Screens/playlist/playlist.dart';
import 'package:music_project/Screens/recentlyPlayed/recentlyplayed.dart';
import 'package:music_project/Screens/searchScreen/searchscreen.dart';
import 'package:music_project/Screens/settings/settingscreen.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/constans/images/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            )
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
                        builder: (context) => PlayList(),
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
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 18),
              child: Column(
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
                              builder: (context) => AllSongs(),
                            ));
                      },
                      child: Text(
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
                  Container(
                    height: 250,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PlayinNow(),
                                    )),
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
                                        child: Image(
                                          image: AssetImage(photos[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          top: 185,
                                          left: 25,
                                          child: Text(
                                            photostName[index].toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100),
                                          ))
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
                        itemCount: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayList(),
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
                    height: 190,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
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
                                      top: 165,
                                      left: 12,
                                      child: Text(
                                          playlisttName[index].toUpperCase(),
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
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
                  Slider(
                    value: 0.0,
                    onChanged: (value) {},
                  ),
                  ListTile(
                    leading: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayinNow(),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .3, color: Colors.white),
                          color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage('assets/images/chaff&dust.png'),
                              fit: BoxFit.cover),
                        ),
                        width: 50,
                        height: 60,
                      ),
                    ),
                    title: Text(
                      'Chaff & Dust',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'HYONNA',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.pause,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
