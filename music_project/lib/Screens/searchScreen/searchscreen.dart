import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_project/constans/color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
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
            ],
          ),
        ),
      ),
    );
  }
}
