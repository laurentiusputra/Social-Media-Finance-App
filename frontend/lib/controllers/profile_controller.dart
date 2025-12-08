import 'package:intl/intl.dart';
import '../models/user_model.dart';

class ProfileController {
  // 1. BUAT SINGLETON (Agar data user konsisten di semua halaman)
  static final ProfileController _instance = ProfileController._internal();
  factory ProfileController() => _instance;
  ProfileController._internal();

  // 2. VARIABLE PENYIMPAN DATA (State Sementara)
  UserModel? _currentUser;

  // 3. FUNGSI AMBIL DATA (Load sekali saja)
  Future<UserModel> getUserProfile() async {
    // Kalau data sudah ada (sudah pernah load), kembalikan yang ada
    if (_currentUser != null) return _currentUser!;

    await Future.delayed(const Duration(seconds: 1));

    // Data Awal (Dummy)
    _currentUser = UserModel(
      name: "Laurentius Dedyluca",
      username: "laurentius_dp",
      avatarUrl: "https://i.pravatar.cc/150?img=12",
      accountNumber: "222 - 888 - 1029",
      balance: 250000000000, // Saldo Awal
      transferCount: "24",
      income: "1.2M",
      points: "850",
      isVerified: true,
    );

    return _currentUser!;
  }

  // 4. FUNGSI POTONG SALDO (Transfer Logic)
  bool deductBalance(double amount) {
    if (_currentUser == null) return false;
    
    // Cek apakah saldo cukup?
    if (_currentUser!.balance >= amount) {
      // Update data user dengan saldo baru
      _currentUser = UserModel(
        name: _currentUser!.name,
        username: _currentUser!.username,
        avatarUrl: _currentUser!.avatarUrl,
        accountNumber: _currentUser!.accountNumber,
        balance: _currentUser!.balance - amount, // <--- KURANGI SALDO
        transferCount: (int.parse(_currentUser!.transferCount) + 1).toString(), // Tambah jumlah transfer
        income: _currentUser!.income,
        points: (int.parse(_currentUser!.points) + 50).toString(), // Dapat poin
        isVerified: _currentUser!.isVerified,
      );
      return true; // Berhasil
    } else {
      return false; // Gagal (Saldo kurang)
    }
  }

  String formatRupiah(double amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    return formatter.format(amount);
  }
}