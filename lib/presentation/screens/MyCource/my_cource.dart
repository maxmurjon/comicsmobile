import 'package:flutter/material.dart';
import '../../../presentation/screens/VideoDetail/data/models/course.dart'; // Course modelini import qilish
import '../../../presentation/screens/MyCource/Course/course.dart'; // Kurs detallari sahifasi
import '../../../presentation/screens/home/data/get_course.dart';

class MyCource extends StatefulWidget {
  const MyCource({Key? key}) : super(key: key);

  @override
  _CourceGridState createState() => _CourceGridState();
}

class _CourceGridState extends State<MyCource> {
  List<Course> courses = []; // Kurslar ro'yxati
  bool isLoading = true; // Yuklanish holati

  @override
  void initState() {
    super.initState();
    fetchCourses(); // Kurslarni yuklashni boshlash
  }

  Future<void> fetchCourses() async {
    GetCourse apiService = GetCourse(); // ApiService obyektini yaratish
    final courseData = await apiService.fetchCourses();

    if (courseData != null) {
      setState(() {
        courses = courseData; // Backenddan kelgan kurslarni saqlash
        isLoading = false; // Yuklanish tugadi
      });
    } else {
      setState(() {
        isLoading = false; // Xatolik bo'lsa, yuklanishni to'xtatish
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator()) // Yuklanish indikatori
        : courses.isEmpty
        ? const Center(child: Text("Kurslar mavjud emas"))
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5, // GridView balandligi
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: courses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final Course course = courses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailScreen(course: course),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        child: course.imageUrl != null
                            ? Image.network(
                          course.imageUrl!,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey), // Agar rasm yo'q bo'lsa
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${course.priceTutor} UZS / ${course.priceNoTutor} UZS',
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
