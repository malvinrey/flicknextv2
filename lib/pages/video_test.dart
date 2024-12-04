import 'package:flutter/material.dart';  
import 'package:video_player/video_player.dart';  

void main() {  
  runApp(VideoTestApp());  
}  

class VideoTestApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'Video Test',  
      theme: ThemeData(  
        primarySwatch: Colors.blue,  
      ),  
      home: VideoTestPage(),  
    );  
  }  
}  

class VideoTestPage extends StatefulWidget {  
  @override  
  _VideoTestPageState createState() => _VideoTestPageState();  
}  

class _VideoTestPageState extends State<VideoTestPage> {  
  late VideoPlayerController _controller;  
  bool isInitialized = false;  

  @override  
  void initState() {  
    super.initState();  
    // Initialize the video controller  
    _controller = VideoPlayerController.asset('assets/videos/titanic.mp4')  
      ..initialize().then((_) {  
        setState(() {  
          isInitialized = true;  
        });  
        _controller.setLooping(true); // Loop the video  
        _controller.play(); // Start the video  
      });  
  }  

  @override  
  void dispose() {  
    _controller.dispose(); // Dispose the controller when done  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Video Player Test'),  
      ),  
      body: Center(  
        child: isInitialized  
            ? AspectRatio(  
                aspectRatio: _controller.value.aspectRatio,  
                child: VideoPlayer(_controller),  
              )  
            : CircularProgressIndicator(), // Show loading until initialized  
      ),  
    );  
  }  
}