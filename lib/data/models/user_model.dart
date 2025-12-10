class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final bool emailVerified;
  final bool phoneVerified;
  final bool kycCompleted;
  final double walletBalance;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    this.emailVerified = false,
    this.phoneVerified = false,
    this.kycCompleted = false,
    this.walletBalance = 0.0,
    required this.createdAt,
    this.lastLoginAt,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      photoUrl: json['photoUrl'],
      emailVerified: json['emailVerified'] ?? false,
      phoneVerified: json['phoneVerified'] ?? false,
      kycCompleted: json['kycCompleted'] ?? false,
      walletBalance: (json['walletBalance'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'kycCompleted': kycCompleted,
      'walletBalance': walletBalance,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }
  
  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    bool? emailVerified,
    bool? phoneVerified,
    bool? kycCompleted,
    double? walletBalance,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      kycCompleted: kycCompleted ?? this.kycCompleted,
      walletBalance: walletBalance ?? this.walletBalance,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
