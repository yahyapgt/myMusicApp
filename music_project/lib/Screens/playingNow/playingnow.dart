import 'package:flutter/material.dart';

class PlayinNow extends StatelessWidget {
  const PlayinNow({super.key});

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
        title: Text(
          'Playing Now',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff061126),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  height: 210,
                  width: 210,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/mask-group-ddA.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Shortwave',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'RYAN GRIGDRY',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              SizedBox(
                height: 130,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '00.0',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Slider(
                    value: 0.0,
                    onChanged: (value) {},
                  ),
                  Text(
                    '00.0',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.pause,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
