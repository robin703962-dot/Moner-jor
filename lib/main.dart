import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(MonerJorApp());

class MonerJorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MoodScreen(),
    );
  }
}

class MoodScreen extends StatelessWidget {
  final Map<String, List<String>> videos = {
    'হতাশ': ['jfKfPfyJRdk', 'ZXsQAXx_ao0'],
    'রাগ': ['pRpeEdMmmQ0', 'VbfpW0pbvaU'],
    'জিততে চাই': ['mgmVOuLgFB0', 'UNQhuFL6CWg'],
  };

  void playVideo(BuildContext context, String mood) {
    final videoList = videos!;
    videoList.shuffle();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoScreen(videoId: videoList[0]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('আজ কেমন লাগছে?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('জয়ের অধিকার, আমার হাতিয়ার', style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 60),
              MoodButton(text: '😔 হতাশ লাগছে', onTap: () => playVideo(context, 'হতাশ')),
              MoodButton(text: '😤 রাগ লাগছে', onTap: () => playVideo(context, 'রাগ')),
              MoodButton(text: '🔥 জিততে চাই', onTap: () => playVideo(context, 'জিততে চাই')),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  MoodButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[900],
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  final String videoId;
  VideoScreen({required this.videoId});
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: YoutubePlayer(controller: _controller)),
    );
  }
}
