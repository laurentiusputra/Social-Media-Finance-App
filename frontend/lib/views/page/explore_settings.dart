import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';

class ExploreSettingsPage extends StatefulWidget {
  const ExploreSettingsPage({super.key});

  @override
  State<ExploreSettingsPage> createState() => _ExploreSettingsPageState();
}

class _ExploreSettingsPageState extends State<ExploreSettingsPage> {
  // Dummy State untuk Switch
  bool _showPersonalized = true;
  bool _autoplayVideos = false;
  bool _highQualityImages = true;
  bool _topicInvestment = true;
  bool _topicCrypto = true;
  bool _topicTech = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- CUSTOM HEADER ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    width: 5,
                  ), // Jarak dikit antara panah dan judul
                  const Text(
                    "Explore Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Ukuran font header
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // --- KONTEN SETTINGS (Scrollable) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("PREFERENCES"),
                    _buildSwitchTile(
                      "Personalized Recommendations",
                      "Show content based on your activity",
                      _showPersonalized,
                      (val) => setState(() => _showPersonalized = val),
                    ),
                    _buildSwitchTile(
                      "Autoplay Videos",
                      "Play videos automatically on Wi-Fi",
                      _autoplayVideos,
                      (val) => setState(() => _autoplayVideos = val),
                    ),
                    _buildSwitchTile(
                      "High Quality Images",
                      "Load original resolution images",
                      _highQualityImages,
                      (val) => setState(() => _highQualityImages = val),
                    ),

                    const SizedBox(height: 25),

                    _buildSectionTitle("INTERESTS"),
                    _buildSwitchTile(
                      "Investment & Stocks",
                      "Show market updates",
                      _topicInvestment,
                      (val) => setState(() => _topicInvestment = val),
                    ),
                    _buildSwitchTile(
                      "Crypto & Blockchain",
                      "Show crypto news",
                      _topicCrypto,
                      (val) => setState(() => _topicCrypto = val),
                    ),
                    _buildSwitchTile(
                      "Technology & AI",
                      "Show tech innovations",
                      _topicTech,
                      (val) => setState(() => _topicTech = val),
                    ),

                    const SizedBox(height: 25),

                    _buildSectionTitle("HISTORY"),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        "Clear Search History",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      subtitle: const Text(
                        "Remove all recent searches",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      trailing: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Search history cleared!"),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30), // Spasi bawah tambahan
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SwitchListTile(
        activeThumbColor: Colors.blueAccent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
