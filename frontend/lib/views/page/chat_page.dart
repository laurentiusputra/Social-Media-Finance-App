import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground, // Header biru
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        title: const Text("Chats", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
        actions: [
          IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.edit_square, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // 1. SEARCH BAR (Gaya IG)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text("Search", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. ACTIVE USERS (Gaya IG - Story like)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildActiveUserItem(index);
                },
              ),
            ),

            // 3. CHAT LIST (Gaya WA/IG Hybrid)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _buildChatItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryBackground,
        child: const Icon(Icons.add_comment_rounded, color: Colors.white),
      ),
    );
  }

  // WIDGET: USER AKTIF (BULAT)
  Widget _buildActiveUserItem(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=${index + 10}"),
              ),
              Positioned(
                bottom: 2, right: 2,
                child: Container(
                  width: 14, height: 14,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text("User Name", style: TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }

  // WIDGET: ITEM CHAT LIST
  Widget _buildChatItem(BuildContext context, int index) {
    return ListTile(
      onTap: () {
        // Navigasi ke Detail Chat
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatDetailScreen()));
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=${index + 20}"),
      ),
      title: Text(
        "Teman ${index + 1}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Row(
        children: [
          if (index % 3 == 0) // Simulasi centang biru (read)
            const Icon(Icons.done_all, size: 16, color: Colors.blueAccent),
          if (index % 3 == 0) const SizedBox(width: 5),
          
          Expanded(
            child: Text(
              index % 2 == 0 ? "Halo, apa kabar? Project gimana?" : "Siap, otw gan! 🚀",
              style: TextStyle(
                color: index == 0 ? Colors.black87 : Colors.grey, // Bold kalau belum dibaca
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("12:30", style: TextStyle(fontSize: 12, color: index == 0 ? Colors.blue : Colors.grey)),
          const SizedBox(height: 5),
          if (index == 0) // Badge unread
            Container(
              width: 20, height: 20,
              decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: const Center(child: Text("2", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
            ),
        ],
      ),
    );
  }
}

// ==========================================
// HALAMAN DETAIL CHAT (CONVERSATION ROOM)
// ==========================================
class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background agak abu WA style
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=20"),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Teman 1", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Active now", style: TextStyle(color: Colors.green[600], fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam_outlined, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.info_outline, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // LIST PESAN
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDateSeparator("Today"),
                _buildMessageBubble("Halo bro, project aman?", isMe: false, time: "10:00"),
                _buildMessageBubble("Aman bro, udah update fiturnya nih.", isMe: true, time: "10:05", isRead: true),
                _buildMessageBubble("Mantap! Kirim screenshot dong.", isMe: false, time: "10:06"),
                _buildMessageBubble("Oke wait ya...", isMe: true, time: "10:07", isRead: true),
                // Simulasi Gambar
                _buildImageBubble(), 
                _buildMessageBubble("Gimana menurutmu?", isMe: true, time: "10:08", isRead: false),
              ],
            ),
          ),

          // INPUT FIELD (Gaya IG/WA Hybrid)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.add_circle, color: Colors.blueAccent, size: 28), onPressed: () {}),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey[300]!)
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Message...", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                // Ikon-ikon ala WA/IG
                IconButton(icon: const Icon(Icons.mic_none_outlined, color: Colors.black87), onPressed: () {}),
                IconButton(icon: const Icon(Icons.image_outlined, color: Colors.black87), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String text) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ),
    );
  }

  Widget _buildMessageBubble(String message, {required bool isMe, required String time, bool isRead = false}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 250), // Batas lebar bubble
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          // Warna: Kalau kita (Biru/Ungu IG), Kalau orang lain (Putih/Abu)
          color: isMe ? const Color(0xFF3797F0) : Colors.white, 
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isMe ? const Radius.circular(20) : Radius.zero, // Ekor bubble
            bottomRight: isMe ? Radius.zero : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Biar waktu di kanan
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(time, style: TextStyle(fontSize: 10, color: isMe ? Colors.white70 : Colors.grey)),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.done_all, size: 14, color: isRead ? Colors.white : Colors.white60), // Centang WA Style
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBubble() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("https://picsum.photos/300/200"),
          ),
        ),
      ),
    );
  }
}