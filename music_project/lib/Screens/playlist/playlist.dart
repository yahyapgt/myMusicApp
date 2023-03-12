import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/constans/images/images.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff061126),
      appBar: AppBar(
        backgroundColor: Color(0xff061126),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.navigate_before,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Playlist',
            style: TextStyle(
              color: Color(0xffeaf0ff),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text(
                  'Add New Playlists',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 7,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      // image: DecorationImage(image: AssetImage(photos[index])),
                      borderRadius: BorderRadius.circular(9),
                      color: primaryColor),
                  margin: EdgeInsets.all(25),
                  child: Stack(
                    children: [
                      Container(
                        color: primaryColor,
                        height: 120,
                        width: double.infinity,
                        child: Image.asset(
                          playPhotos[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          top: 122,
                          left: 7,
                          child: Text(
                            playlisttName[index].toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
