import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_app/AudioHomePageWidget.dart';
import 'package:audio_app/SpeechRecognitionWidget.dart';

import 'package:flutter/material.dart';

void main() => runApp(BrijApp());

class BrijApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SpeechRecognitionWidget(),
    );
  }
}

class OptionsHomePage extends StatelessWidget {
  List<String> populateMenus() {
    return ['Play Audio', 'Audio to Text'];
  }

  @override
  Widget build(BuildContext context) {
    List<String> array = populateMenus();
    return Scaffold(
        appBar: AppBar(
          title: Text('Audio'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: array.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                    child: IconButton(
                        icon: Icon(Icons.ac_unit, color: Colors.white),
                        onPressed: null)),
                title: Text('${array[index]}'),
                onTap: () => {},
              );
            },
          ),
        ));
  }
}
