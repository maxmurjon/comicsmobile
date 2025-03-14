import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../Widgets/hls_player.dart';
import '../../VideoDetail/data/models/course.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course; // Course data passed from API

  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _showCourseDetails = true;
  List<Section> _sections = [];
  Map<int, List<Video>> _sectionVideos = {};
  bool _isLoading = true;
  String _selectedVideoTitle = 'Select a Video';
  String? _selectedVideoUrl = "http://84.247.139.211:8000/coursesvideo/hls/1080p/1/playlist.m3u8"; // Statik URL
  int? _selectedVideoIndex;

  @override
  void initState() {
    super.initState();
    _fetchCourseData();
  }

  Future<void> _fetchCourseData() async {
    try {
      List<Section> sections = await fetchSections(widget.course.id);

      for (var section in sections) {
        List<Video> videos = await fetchVideos(section.id);
        _sectionVideos[section.id] = videos;
      }

      setState(() {
        _sections = sections;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF4d008c),
              ),
              child: Column(
                children: const [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  Text(
                    'Maxmur Keldiyorov',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _sections.isNotEmpty
                ? Column(
              children: _sections.map((section) {
                return ExpansionTile(
                  title: Text(
                    section.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: _sectionVideos[section.id]
                      ?.map((video) {
                    final isSelected =
                        _selectedVideoIndex == video.id;
                    return ListTile(
                      leading: const Icon(Icons.video_library),
                      title: Text(video.title),
                      subtitle:
                      Text("Duration: ${video.duration} sec"),
                      tileColor: isSelected
                          ? const Color(0xFF4d008c).withOpacity(0.5)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedVideoTitle = video.title;
                          _selectedVideoUrl = video.url;
                          _selectedVideoIndex = video.id;
                        });
                      },
                    );
                  }).toList() ??
                      [
                        const Center(child: Text("No videos available"))
                      ],
                );
              }).toList(),
            )
                : const Center(child: Text("No course sections available")),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_selectedVideoTitle,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildVideoPlayerArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerArea() {
    if (_selectedVideoUrl == null || _selectedVideoUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.play_circle_fill,
            size: 50,
            color: Colors.white,
          ),
        ),
      );
    }

    print("Selected Video URL: $_selectedVideoUrl");

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: HLSVideoPlayerWidget(
        videoUrl: _selectedVideoUrl ?? "",
      ),
    );
  }
}
