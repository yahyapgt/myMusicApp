import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
                label: Text('Add New Playlist')),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 7,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(playPhotos[index]),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(7),
                    color: Color.fromARGB(255, 220, 211, 211),
                  ),
                  margin: EdgeInsets.all(25),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
