import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // State untuk sembunyikan/tampilkan saldo
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih bersih ala IG
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              "laurentius_dp", // Username ala IG
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.verified, color: Colors.blue, size: 18),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HEADER PROFILE (STYLE IG) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Foto Profil
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
                        ),
                      ),
                      // Stats
                      _buildStatItem("24", "Transfers"),
                      _buildStatItem("1.2M", "Income"),
                      _buildStatItem("850", "Points"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Laurentius Dedyluca",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text(
                    "Digital Creator & Investor 🚀\nBuilding wealth one step at a time.",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- 2. DIGITAL WALLET CARD (STYLE BCA/FINTECH) ---
            // Menggunakan Gradasi sesuai screenshot BCA yang kamu kirim
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // Gradasi Biru Muda ke Biru Tua
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4AC7F5), // Biru Langit (Kiri Atas)
                    Color(0xFF1E88E5), // Biru BCA (Tengah)
                    Color(0xFF0F4C75), // Biru Gelap (Kanan Bawah)
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header Kartu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white54),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.qr_code, color: Colors.white, size: 16),
                            SizedBox(width: 5),
                            Text("BCA ID", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Icon(Icons.contactless, color: Colors.white70),
                    ],
                  ),
                  
                  // Nomor Akun
                  Row(
                    children: [
                      const Text(
                        "Account: 222 - 2920 - 2910",
                        style: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 1),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.copy, color: Colors.white.withOpacity(0.7), size: 14),
                    ],
                  ),

                  const Spacer(),

                  // Saldo & Mata (Fitur Show/Hide)
                  const Text("Active Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isBalanceVisible ? "IDR 524.00" : "IDR •••••••",
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 28, 
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monospace' // Biar kayak angka bank
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isBalanceVisible ? Icons.remove_red_eye : Icons.visibility_off, 
                          color: Colors.white
                        ),
                        onPressed: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- 3. ACTION MENU (STYLE WECHAT / SUPER APP) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(Icons.send_rounded, "Transfer", Colors.green),
                  _buildActionButton(Icons.qr_code_scanner, "Scan QR", Colors.blue),
                  _buildActionButton(Icons.add_card, "Top Up", Colors.orange),
                  _buildActionButton(Icons.history, "History", Colors.purple),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Divider(thickness: 1, height: 1),

            // --- 4. TABS CONTENT (STYLE IG GRID) ---
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on)), // Posts
                      Tab(icon: Icon(Icons.video_library)), // Reels/Investasi
                      Tab(icon: Icon(Icons.person_pin_outlined)), // Tagged
                    ],
                  ),
                  SizedBox(
                    height: 400, // Tinggi Grid
                    child: TabBarView(
                      children: [
                        _buildGridContent(), // Tab 1: Grid
                        const Center(child: Text("Investment Portfolio")),
                        const Center(child: Text("Tagged Photos")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 55, height: 55,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildGridContent() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Image.network(
          "https://picsum.photos/200/200?random=$index",
          fit: BoxFit.cover,
        );
      },
    );
  }
}