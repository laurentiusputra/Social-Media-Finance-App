import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import '../../../../views/page/colors.dart';
import '../../controllers/profile_controller.dart'; 

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  // Dummy Contacts
  final List<Map<String, String>> _recentContacts = [
    {'name': 'Mike', 'img': 'https://media.tenor.com/KUXIWC9D5_UAAAAi/my-hero-academia-boku-no-hero-academia.gif'},
    {'name': 'Kazuha', 'img': 'https://i.pravatar.cc/150?img=33'},
    {'name': 'Jokowi', 'img': 'https://i.pravatar.cc/150?img=11'},
    {'name': 'Lisa', 'img': 'https://i.pravatar.cc/150?img=5'},
    {'name': 'Elon', 'img': 'https://i.pravatar.cc/150?img=60'},
  ];

  int _selectedContactIndex = -1; 

  // --- FUNGSI FORMATTER RUPIAH ---
  void _formatInputCurrency(String value) {
    // 1. Hapus semua karakter selain angka
    String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanValue.isNotEmpty) {
      // 2. Parse ke integer
      double number = double.parse(cleanValue);

      // 3. Format ke Rupiah (Tanpa Simbol IDR, cuma angka dan titik)
      String formatted = NumberFormat.currency(
        locale: 'id_ID', 
        symbol: '', 
        decimalDigits: 0
      ).format(number).trim();

      // 4. Update Controller & Jaga posisi Kursor di akhir
      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      _amountController.clear();
    }
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Transfer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.history, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. RECENT CONTACTS
            const Text("Send to", style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _recentContacts.length + 1, 
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildAddNewContact();
                  }
                  return _buildContactItem(index - 1);
                },
              ),
            ),

            const SizedBox(height: 30),

            // 2. INPUT AMOUNT
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  const Text("Enter Amount", style: TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("IDR ", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 2)),
                      IntrinsicWidth(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(color: Colors.white30),
                            border: InputBorder.none,
                          ),
                          // Panggil Formatter saat ngetik
                          onChanged: (val) {
                            _formatInputCurrency(val);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 10),
                  
                  // Quick Amount Chips
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildQuickAmountChip("50k", "50000"),
                      _buildQuickAmountChip("100k", "100000"),
                      _buildQuickAmountChip("250k", "250000"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. NOTES
            TextField(
              controller: _noteController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                hintText: "Add a note (optional)...",
                hintStyle: const TextStyle(color: Colors.white30),
                prefixIcon: const Icon(Icons.edit, color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 40),

            // 4. SEND BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationSheet();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS HELPER ---

  Widget _buildAddNewContact() {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30, width: 1, style: BorderStyle.solid), // Solid biar gak error
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text("New", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildContactItem(int index) {
    bool isSelected = _selectedContactIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedContactIndex = index),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected ? Border.all(color: Colors.blueAccent, width: 2) : null,
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(_recentContacts[index]['img']!),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _recentContacts[index]['name']!,
              style: TextStyle(
                color: isSelected ? Colors.blueAccent : Colors.white70,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Amount Chip (Update logic agar format angka jalan)
  Widget _buildQuickAmountChip(String label, String value) {
    return GestureDetector(
      onTap: () {
        _formatInputCurrency(value); // Format angka saat diklik
      },
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.white, 
        labelStyle: const TextStyle(
          color: Colors.black87, 
          fontWeight: FontWeight.bold
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // POP UP KONFIRMASI & EKSEKUSI TRANSFER
  void _showConfirmationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        // Ambil nominal murni (tanpa titik)
        String cleanValue = _amountController.text.replaceAll('.', '');
        double transferAmount = double.tryParse(cleanValue) ?? 0;

        return Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 25),
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 60),
              const SizedBox(height: 15),
              const Text("Confirm Transfer", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Are you sure you want to send?", style: TextStyle(color: Colors.white60)),
              const SizedBox(height: 20),
              Text("IDR ${_amountController.text}", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // 👇 LOGIKA UTAMA: POTONG SALDO DI CONTROLLER
                    bool success = ProfileController().deductBalance(transferAmount);

                    if (success) {
                      Navigator.pop(context); // Tutup Sheet
                      Navigator.pop(context, true); // Kembali ke Profile + Kirim sinyal True
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Transfer Success! 💸 Saldo Berkurang."),
                          backgroundColor: Colors.green,
                        )
                      );
                    } else {
                      Navigator.pop(context); // Tutup Sheet
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Saldo Tidak Cukup! ❌"),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  child: const Text("Send Now", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}