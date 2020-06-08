import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';

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
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  final List<int> array = List<int>.generate(9, (index) => index + 1);
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Play Audio'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: array.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${array[index]}')),
                title: Text('Data for - ${array[index]}'),
                onTap: () => playAudioFromLocalAsset(array[index]),
              );
            },
          ),
        ));
  }

  void playAudioFromLocalAsset(int fileNum) async {
    //fileNum == null ? fileNum = 1 : fileNum++;
    print('In playAudioFromLocalAsset audio file : assets/$fileNum.mp3');
    try {
      await _assetsAudioPlayer.open(
        Audio("assets/$fileNum.mp3"),
      );
    } catch (t) {print('In playAudioFromLocalAsset ERROR : mp3 unreachable! $t');
      _assetsAudioPlayer.dispose();
      _assetsAudioPlayer = AssetsAudioPlayer(); 
      
    }
  }

  void playAudioFromNetWork() async {
    try {
      await _assetsAudioPlayer.open(
        Audio.network(
            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
      );
    } catch (t) {
      print('In playAudioFromNetWork audio ERROR : mp3 unreachable!');
    }
  }
}
