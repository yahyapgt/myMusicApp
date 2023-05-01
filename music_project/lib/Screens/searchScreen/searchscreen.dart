import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_project/Screens/allSongs/allsongslibrary.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/controller/controls.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    songsLoading();
    super.initState();
  }

  List<SongModel> allsongs = [];
  List<SongModel> foundSongs = [];
  final audioQuery = OnAudioQuery();

  Widget _icon_buttom(var _icon) {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          _icon,
          color: const Color.fromARGB(255, 0, 0, 0),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
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
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text(
            'Search',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Search your favourite tracks',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 45,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                      onChanged: (value) => updateList(value),
                      decoration: InputDecoration(
                          suffixIcon: _icon_buttom(Icons.search_rounded),
                          prefixIcon: _icon_buttom(Icons.music_note_outlined),
                          hintText: "Search something.....",
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  style: BorderStyle.solid,
                                  width: 5,
                                  color: Colors.white),
                              borderRadius: BorderRadius.circular(50))))

                  //  ))),
                  ),
              Expanded(
                  child: AllsongControll(
                itemsongs: foundSongs,
              ))
            ],
          ),
        ),
      ),
    );
  }

  void songsLoading() async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    setState(() {
      foundSongs = allsongs;
    });
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .trim()
              .contains(enteredText.toLowerCase().trim()))
          .toList();
    }
    setState(() {
      foundSongs = results;
    });
  }
 
}
