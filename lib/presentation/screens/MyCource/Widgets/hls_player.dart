import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HLSVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const HLSVideoPlayerWidget({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _HLSVideoPlayerWidgetState createState() => _HLSVideoPlayerWidgetState();
}

class _HLSVideoPlayerWidgetState extends State<HLSVideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    try {
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.isInitialized
            ? _videoPlayerController.value.aspectRatio
            : 16/9, // Default aspect ratio (16:9) if not initialized
        autoPlay: true,
        looping: false,
      );

      setState(() {});
    } catch (e) {
      print('Error during video player initialization: $e');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized
        ? Container(
      height: 250, // Adjust the height according to your design
      width: double.infinity,
      child: Chewie(controller: _chewieController!),
    )
        : const Center(child: CircularProgressIndicator());
  }
}
