import 'package:flutter/material.dart';
import '../../../presentation/screens/VideoDetail/data/models/course.dart'; // Replace with actual model imports

class CourseDetailScreen extends StatefulWidget {
  final Course course; // Course data passed from API

  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _showCourseDetails = true;
  List<Section> _sections = []; // Sections data
  Map<int, List<Video>> _sectionVideos = {}; // Videos mapped by section ID
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCourseData();
  }

  Future<void> _fetchCourseData() async {
    try {
      // Fetch sections for the course
      List<Section> sections = await fetchSections(widget.course.id);

      // Fetch videos for each section
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
      appBar: null, // Removing the app bar
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Image with Back Arrow on Top Left
                Stack(
                  children: [
                    if (widget.course.imageUrl != null)
                      GestureDetector(
                        onTap: () => _showFullScreenImage(context, widget.course.imageUrl!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.course.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
                      ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Course Title
                Text(
                  widget.course.title,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Tab Switcher with full width buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() => _showCourseDetails = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _showCourseDetails ? const Color(0xFF4d008c) : Colors.grey,
                        ),
                        child: const Text('Kurs Tarkibi', style: TextStyle(
                          color: Colors.white,
                        )),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() => _showCourseDetails = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !_showCourseDetails ? const Color(0xFF4d008c) : Colors.grey,
                        ),
                        child: const Text('Kurs Haqida', style: TextStyle(
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Conditional Rendering
                _showCourseDetails ? _buildCourseContent() : _buildCourseDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _sections.map((section) {
        return ExpansionTile(
          title: Text(section.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          children: _sectionVideos[section.id]?.map((video) {
            return ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(video.title),
              subtitle: Text("Duration: ${video.duration} sec"),
              trailing: const Icon(Icons.lock, color: Colors.grey), // Lock icon added here
              onTap: () {
                // Empty onTap to ensure no action happens when tapping on the video
                print("Video locked: ${video.title}");
              },
            );
          }).toList() ?? [const Center(child: Text("No videos available"))],
        );
      }).toList(),
    );
  }

  Widget _buildCourseDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.course.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Text(
          "Narxi (Ustoz bilan): \$${widget.course.priceTutor.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          "Narxi (Ustozsiz): \$${widget.course.priceNoTutor.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}