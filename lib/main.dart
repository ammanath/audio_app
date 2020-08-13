import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_app/AudioHomePageWidget.dart';
import 'package:audio_app/SpeechRecognitionWidget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';

void main() => runApp(BrijApp());

class BrijApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: SpeechScreen(), //SpeechRecognitionWidget(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.lime,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking!';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 150),
          color: Colors.black,
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print('available is $available');
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                  if (val.hasConfidenceRating && val.confidence > 0) {
                    _confidence = val.confidence;
                  }
                }));
      } else {
        setState(() {
          _isListening = false;
          _speech.stop();
        });
      }
    }
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
