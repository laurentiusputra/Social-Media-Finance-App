import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';

class PostDetailPage extends StatelessWidget {
  final String imageUrl;
  final String heroTag; // ID Unik untuk animasi terbang

  const PostDetailPage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground, // Background Biru Gelap 
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("laurentius_dp", style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("Posts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
      // LISTVIEW BUILDER: Membuat daftar postingan tanpa batas
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        itemCount: 15, 
        itemBuilder: (context, index) {
          // INDEX 0 = Postingan yang sedang diklik (Gambar Utama)
          // INDEX > 0 = Postingan selanjutnya di profil
          
          if (index == 0) {
            return _buildPostCard(
              image: imageUrl, 
              tag: heroTag, 
              caption: "Enjoying the view and analyzing the market! 🚀\n\nFinancial freedom starts with the right mindset. Keep building, keep investing.\n\n#Investment #Life #Crypto"
            );
          } else {
            // Postingan Lanjutan (Simulasi data dari profil)
            return _buildPostCard(
              image: "https://picsum.photos/500/500?random=$index", // Gambar urutan profil
              tag: "post_$index", // Tag biasa
              caption: "Another day, another opportunity. Consistency is key! 🔑 #DailyGrind #Fintech",
              timeAgo: "${index + 1} days ago",
              likes: "${(index + 5) * 120}"
            );
          }
        },
      ),
    );
  }

  // --- WIDGET KARTU POSTINGAN (SATU DESAIN UNTUK SEMUA) ---
  Widget _buildPostCard({
    required String image, 
    required String tag, 
    required String caption, 
    String timeAgo = "2 hours ago",
    String likes = "12.4k"
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Jarak antar postingan
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground, // Tetap biru gelap
        border: Border(bottom: BorderSide(color: Colors.white12, width: 0.5)), // Garis pemisah
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HEADER (Avatar + Nama)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18, 
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12") // Foto User sama dengan Profil
                ), 
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "laurentius_dp", 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)
                      ),
                      Text("Singapore, SG", style: TextStyle(color: Colors.white60, fontSize: 11)),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),

          // 2. GAMBAR POST (Full Width)
          Hero(
            tag: tag,
            child: Container(
              height: 400, // Tinggi gambar proporsional
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),
          ),

          // 3. ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite_border, size: 26, color: Colors.white),
                    SizedBox(width: 20),
                    Icon(Icons.chat_bubble_outline, size: 26, color: Colors.white),
                    SizedBox(width: 20),
                    Icon(Icons.send_outlined, size: 26, color: Colors.white),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 26, color: Colors.white),
              ],
            ),
          ),

          // 4. LIKES & CAPTION & KOMENTAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$likes likes", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 6),
                
                // Caption Rich Text
                Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.white),
                    children: [
                      const TextSpan(text: "laurentius_dp ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: caption),
                    ],
                  ),
                ),
                
                const SizedBox(height: 6),
                const Text("View all comments", style: TextStyle(color: Colors.white54, fontSize: 13)),
                const SizedBox(height: 4),
                Text(timeAgo, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
