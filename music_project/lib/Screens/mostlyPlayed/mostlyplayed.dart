import 'package:flutter/material.dart';
import 'package:music_project/constans/color.dart';
import 'package:music_project/constans/images/images.dart';

class MostlyPlayed extends StatelessWidget {
  const MostlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          'Mostly Played',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
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
                    'Mostly Played Songs',
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
                  child: Stack(
                    children: [
                      Container(
                        color: primaryColor,
                        height: 120,
                        width: double.infinity,
                        child: Image.asset(
                          mostlyPhotos[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          top: 122,
                          left: 30,
                          child: Text(
                            mostlytName[index].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
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
