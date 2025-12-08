import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';
import '../../../models/user_model.dart';
import '../../../controllers/profile_controller.dart';
import 'post_detail_page.dart';
import 'transfer_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _controller = ProfileController();
  UserModel? _user;
  bool _isLoading = true;
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi reload data (Mengambil data terbaru dari Controller)
  void _loadData() async {
    final data = await _controller.getUserProfile();
    setState(() {
      _user = data;
      _isLoading = false;
    });
  }

  void _navigateTo(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: AppBar(title: Text(title, style: const TextStyle(color: Colors.white)), backgroundColor: AppColors.primaryBackground, iconTheme: const IconThemeData(color: Colors.white)),
          body: Center(child: Text("Halaman $title", style: const TextStyle(fontSize: 24, color: Colors.white))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        title: Row(
          children: [
            Text(_user!.username, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(width: 5),
            if (_user!.isVerified) const Icon(Icons.verified, color: Colors.blue, size: 18),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: () => _navigateTo("Settings"),
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. HEADER PROFILE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white30, width: 2)),
                              child: CircleAvatar(radius: 40, backgroundImage: NetworkImage(_user!.avatarUrl)),
                            ),
                            _buildStatItem(_user!.transferCount, "Transfers"),
                            _buildStatItem(_user!.income, "Income"),
                            _buildStatItem(_user!.points, "Points"),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(_user!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                        const Text(
                          "Digital Creator & Investor 🚀\nBuilding wealth one step at a time.",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 2. WALLET CARD
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                        colors: [Color(0xFF4AC7F5), Color(0xFF1E88E5), Color(0xFF0F4C75)],
                      ),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => _navigateTo("My BCA ID"),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white54)),
                                child: const Row(children: [Icon(Icons.qr_code, color: Colors.white, size: 16), SizedBox(width: 5), Text("BCA ID", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                              ),
                            ),
                            const Icon(Icons.contactless, color: Colors.white70),
                          ],
                        ),
                        Row(children: [Text("Account: ${_user!.accountNumber}", style: const TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 1)), const SizedBox(width: 8), const Icon(Icons.copy, color: Colors.white70, size: 14)]),
                        const Spacer(),
                        const Text("Active Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SALDO AKAN OTOMATIS BERUBAH SETELAH _loadData() DIPANGGIL
                            Text(_isBalanceVisible ? _controller.formatRupiah(_user!.balance) : "IDR •••••••", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Monospace')),
                            IconButton(icon: Icon(_isBalanceVisible ? Icons.remove_red_eye : Icons.visibility_off, color: Colors.white), onPressed: () => setState(() => _isBalanceVisible = !_isBalanceVisible)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 3. ACTION MENU (DENGAN LOGIKA REALTIME)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 👇👇👇 INI LOGIKA REALTIME NYA 👇👇👇
                        _buildActionButton(
                          Icons.send_rounded, 
                          "Transfer", 
                          Colors.green, 
                          () async {
                            // 1. Tunggu (await) sampai halaman Transfer ditutup
                            final result = await Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const TransferPage())
                            );

                            // 2. Jika TransferPage mengirim sinyal 'true' (artinya sukses)
                            if (result == true) {
                              print("Transfer Sukses! Merefresh Saldo...");
                              // 3. Panggil Load Data lagi untuk update tampilan saldo
                              _loadData(); 
                            }
                          }
                        ),
                        // 👆👆👆 LOGIKA SELESAI 👆👆👆

                        _buildActionButton(Icons.qr_code_scanner, "Scan QR", Colors.blue, () => _navigateTo("Scan QR")),
                        _buildActionButton(Icons.add_card, "Top Up", Colors.orange, () => _navigateTo("Top Up")),
                        _buildActionButton(Icons.history, "History", Colors.purple, () => _navigateTo("History")),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ];
        },
        
        // 4. TAB CONTENT
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on)),
                  Tab(icon: Icon(Icons.movie_creation_outlined)),
                  Tab(icon: Icon(Icons.person_pin_outlined)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildGridContent("Post"), 
                    _buildReelsContent(),      
                    _buildGridContent("Tagged"), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---
  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Container(
            width: 55, height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(children: [
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.white60))
    ]);
  }

  Widget _buildGridContent(String type) {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        final imageUrl = "https://picsum.photos/500/500?random=${index + (type == 'Tagged' ? 50 : 0)}";
        final uniqueTag = "$type$index"; 
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(imageUrl: imageUrl, heroTag: uniqueTag))),
          child: Hero(tag: uniqueTag, child: Image.network(imageUrl, fit: BoxFit.cover)),
        );
      },
    );
  }

  Widget _buildReelsContent() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.6, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => _navigateTo("Reels #$index"),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network("https://picsum.photos/200/350?random=${index + 100}", fit: BoxFit.cover),
              Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 40, decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black54, Colors.transparent])))),
              Positioned(bottom: 5, left: 5, child: Row(children: [const Icon(Icons.play_arrow, color: Colors.white, size: 14), Text("${(index + 1) * 2}k", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))])),
            ],
          ),
        );
      },
    );
  }
}