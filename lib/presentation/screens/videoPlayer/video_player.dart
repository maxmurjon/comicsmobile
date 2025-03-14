import 'package:flutter/material.dart';
import '../../../presentation/screens/MyCource/Widgets/hls_player.dart'; // Custom widget for video player

class VideoSelectionScreen extends StatefulWidget {
  @override
  _VideoSelectionScreenState createState() => _VideoSelectionScreenState();
}

class _VideoSelectionScreenState extends State<VideoSelectionScreen> {
  final List<String> videoUrls = [
    'http://84.247.139.211:8000/coursesvideo/hls/1080p/1/playlist.m3u8',
    'http://84.247.139.211:8000/coursesvideo/hls/1080p/1/playlist.m3u8',
    'http://84.247.139.211:8000/coursesvideo/hls/1080p/1/playlist.m3u8',
  ];

  String selectedVideoUrl = 'http://84.247.139.211:8000/coursesvideo/hls/1080p/1/playlist.m3u8'; // Default video

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HLS Video Player'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Select a video to play:'),
          ),
          // Display video URLs list
          Expanded(
            child: ListView.builder(
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  onTap: () {
                    setState(() {
                      selectedVideoUrl = videoUrls[index];
                    });
                  },
                  tileColor: selectedVideoUrl == videoUrls[index]
                      ? Colors.grey.shade300
                      : null,
                );
              },
            ),
          ),
          // Video player widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HLSVideoPlayerWidget(videoUrl: selectedVideoUrl),
          ),
        ],
      ),
    );
  }
}
