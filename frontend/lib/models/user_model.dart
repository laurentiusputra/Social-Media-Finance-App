class UserModel {
  final String name;
  final String username;
  final String avatarUrl;
  final String accountNumber;
  final double balance;
  final String transferCount;
  final String income;
  final String points;
  final bool isVerified;

  UserModel({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.accountNumber,
    required this.balance,
    required this.transferCount,
    required this.income,
    required this.points,
    this.isVerified = false,
  });
}