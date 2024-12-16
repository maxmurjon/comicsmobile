import 'package:flutter/material.dart';
import '../../services/category_service.dart'; // CategoryService ni import qiling
import '../../core/widgets/category_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories =
        CategoryService().fetchCategories(); // API dan ma'lumot olish
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Category>>(
          future: futureCategories, // API dan olingan ma'lumotlar
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Xato: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Kategoriyalar topilmadi.'));
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Har bir qatorga 2 ta kategoriya kartasi
                  crossAxisSpacing: 10, // Kategoriyalar orasidagi bo'shliq
                  mainAxisSpacing: 10, // Qatorlar orasidagi bo'shliq
                ),
                itemCount: categories.length, // Kategoriyalar uzunligi
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryTile(
                    categoryName: category.name, // Kategoriya nomi
                    categoryImage: category.imageUrl, // Kategoriya rasmi
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
