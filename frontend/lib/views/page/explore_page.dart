import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../views/page/colors.dart';
import 'explore_settings.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      // SafeArea bottom: false agar konten bisa discroll sampai bawah navbar
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // 1. HEADER
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white60),
                          prefixIcon: Icon(Icons.search, color: Colors.white60),
                          suffixIcon: Icon(Icons.mic, color: Colors.white60),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExploreSettingsPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 2. KATEGORI TABS
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTab("For You", isActive: true),
                    _buildTab("Investment"),
                    _buildTab("Research"),
                    _buildTab("Entertainment"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: GridView.custom(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                  ), // Biar ngelewatin navbar
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 3, // Bagi layar jadi 3 kolom kecil
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: const [
                      // Pola Grid (Sesuai gambar kamu):
                      QuiltedGridTile(
                        2,
                        1,
                      ), // 1. Kotak Panjang (Tinggi 2, Lebar 1)
                      QuiltedGridTile(1, 1), // 2. Kotak Kecil (1x1)
                      QuiltedGridTile(1, 1), // 3. Kotak Kecil (1x1)
                      QuiltedGridTile(
                        1,
                        2,
                      ), // 4. Kotak Lebar (Tinggi 1, Lebar 2)
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Radius sudut gambar
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              "https://picsum.photos/500/500?random=$index",
                              fit: BoxFit.cover,
                            ),
                            // Ikon Tipe Konten (Video/Gallery/Music)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(
                                _getIconForIndex(index),
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 40, // Jumlah gambar dummy
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper untuk ikon acak di pojok gambar
  IconData _getIconForIndex(int index) {
    if (index % 3 == 0) return Icons.videocam_rounded; // Ikon Video
    if (index % 3 == 1) return Icons.music_note; // Ikon Musik
    return Icons.photo_library_outlined; // Ikon Galeri
  }

  Widget _buildTab(String text, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white60,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }
}
