import 'package:flutter/material.dart';
import '../../../../services/category_service.dart'; // CategoryService ni import qilish

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryService().fetchCategories(); // API’dan malumot olish
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Boxning bo'yi
      child: FutureBuilder<List<Category>>(
        future: futureCategories, // API’dan olingan malumotlar
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Yuklanayotgan holat
          } else if (snapshot.hasError) {
            return Center(child: Text('Xato: ${snapshot.error}')); // Xatolik holati
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Kategoriyalar topilmadi.')); // Kategoriyalar bo'lmasa
          } else {
            final categories = snapshot.data!; // API’dn olingan ma'lumotlar
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length, // Kategoriyalar soni
              itemBuilder: (context, index) {
                final category = categories[index]; // Kategoriyani olish
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 120, // Kategoriyaning kengligi
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), // Burchaklarni yumshatish
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade700,
                          Colors.blue.shade500
                        ], // Gradient fon
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15), // Rasmning burchaklarini yumshatish
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Rasmni joylashtirish
                          Positioned.fill(
                            child: Image.network(
                              category.imageUrl, // API’dan olingan kategoriya rasmi
                              fit: BoxFit.cover, // Rasmni to'liq qoplash
                            ),
                          ),
                          // Kategoriyaning nomi
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              color: Colors.black.withOpacity(0.7), // Matn uchun fon rangi
                              child: Text(
                                category.name, // Kategoriyaning nomi
                                style: TextStyle(
                                  fontSize: 14, // Matn o'lchami
                                  fontWeight: FontWeight.w600, // Matnning semizligi
                                  color: Colors.white, // Yoqimli oq rangda matn
                                  letterSpacing: 1.2, // Harf oralig'ini ko'paytirish
                                ),
                                textAlign: TextAlign.center, // Matnni markazlashtirish
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
