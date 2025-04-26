import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late List<VideoPlayerController?> _controllers;
  final List<String> _videoTitles = [
    'Chill Lofi Vibes 🎶',
    'Dreamy Ukulele Song 🎸',
    'Calm Ambient Music 🌌',
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.filled(3, null);

    _controllers[0] = VideoPlayerController.network(
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    )..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);

    Timer(const Duration(seconds: 3), () {
      _controllers[1] = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      )..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true);
    });

    Timer(const Duration(seconds: 6), () {
      _controllers[2] = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      )..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  Widget buildVideoPlayer(VideoPlayerController? controller, String title) {
    if (controller == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: Text('Waiting to load...')),
      );
    }

    return controller.value.isInitialized
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: VideoPlayer(controller),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                  child: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
        : const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Videos 🎵'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFF9F9F9), // soft light background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            _controllers.length,
            (index) => buildVideoPlayer(_controllers[index], _videoTitles[index]),
          ),
        ),
      ),
    );
  }
}
