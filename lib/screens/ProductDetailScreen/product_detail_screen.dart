import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedFormat = 'Digital'; // Default format: Digital
  int _currentImageIndex = 0; // Slayder uchun hozirgi rasm indeksi

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Image.network(imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rasm slayderi
              if (widget.product.imageUrls.isNotEmpty)
                Stack(
                  children: [
                    // Slayder rasm
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Burchaklarni yumshatish
                        child: PageView.builder(
                          itemCount: widget.product.imageUrls.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _showFullScreenImage(
                                  context, widget.product.imageUrls[index]),
                              child: Image.network(
                                widget.product.imageUrls[index],
                                fit: BoxFit
                                    .cover, // Rasmni gorizontlardan to'liq qamrab olish
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Orqaga qaytish belgisini joylashtirish
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              else
                // Agar rasmlar bo'lmasa
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported,
                      size: 100, color: Colors.grey),
                ),
              const SizedBox(height: 16),

              // Mahsulot nomi
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(height: 8),

              // Mahsulot ta'rifi
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              // Format tanlash
              const Text(
                'Formatni tanlang:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Digital format tugmasi
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFormat = 'Digital';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedFormat == 'Digital'
                              ? Color(0xFF4d008c)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            'Digital',
                            style: TextStyle(
                              color: selectedFormat == 'Digital'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Paper format tugmasi
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFormat = 'Paper';
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedFormat == 'Paper'
                              ? Color(0xFF4d008c)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            'Paper',
                            style: TextStyle(
                              color: selectedFormat == 'Paper'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Narx
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4d008c),
                ),
              ),
              const SizedBox(height: 24),

              // Savatga qo'shish tugmasi
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${widget.product.name} ($selectedFormat) savatga qo\'shildi!'),
                      backgroundColor: Color(0xFF4d008c),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color(0xFF4d008c),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Savatga qo\'shish',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
