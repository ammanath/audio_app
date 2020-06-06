import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(BrijApp());

class BrijApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static AudioCache player = new AudioCache();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Play Audio'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('O')),
                title: Text('data'),
                onTap: () => playAudio(),
              );
            },
          ),
        ));
  }

  void playAudio() {
    const alarmAudioPath = "one.mp3";
    print('In play audio : $alarmAudioPath');
    player.play(alarmAudioPath);
  }
}
