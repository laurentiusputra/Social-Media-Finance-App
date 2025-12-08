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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. HEADER & SEARCH (Ada Padding)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10), // Radius lebih kecil ala IG
                      ),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white60),
                          prefixIcon: Icon(Icons.search, color: Colors.white60, size: 20),
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
                        MaterialPageRoute(builder: (context) => const ExploreSettingsPage()),
                      );
                    },
                    child: const Icon(Icons.settings, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),

            // 2. KATEGORI TABS
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    _buildTab("For You", isActive: true),
                    _buildTab("Investment"),
                    _buildTab("Research"),
                    _buildTab("Entertainment"),
                  ],
                ),
              ),
            ),

            // 3. GRID EXPLORE (FULL WIDTH & SHARP)
            Expanded(
              child: GridView.custom(
                // Padding 0 agar nempel pinggir
                padding: const EdgeInsets.only(bottom: 80), 
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 3, 
                  mainAxisSpacing: 2, // Jarak tipis 2px
                  crossAxisSpacing: 2, // Jarak tipis 2px
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: const [
                    // Pola Grid IG (1 Besar, 2 Kecil)
                    QuiltedGridTile(2, 2), 
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1), 
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          "https://picsum.photos/500/500?random=$index",
                          fit: BoxFit.cover,
                        ),
                        // Ikon Video/Reels di pojok kanan atas
                        if (index % 3 == 0)
                          const Positioned(
                            top: 8, right: 8,
                            child: Icon(Icons.movie, color: Colors.white, size: 20),
                          ),
                      ],
                    );
                  },
                  childCount: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8), // Radius kotak ala IG
        border: Border.all(color: Colors.white30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}