import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Cobacoba extends StatefulWidget {
  @override
  _CobacobaState createState() => _CobacobaState();
}

class _CobacobaState extends State<Cobacoba> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller
    _controller = VideoPlayerController.asset('assets/videos/titanic.mp4')
      ..initialize().then((_) {
        setState(() {
          // Video is initialized
        });
      }).catchError((error) {
        // Handle errors if the video does not load
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player Test'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(_controller), // Show the video player
          ),
          IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
          ),
        ],
      ),
    );
  }
}