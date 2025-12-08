/// User Model
class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? photoUrl;
  final bool emailVerified;
  final bool phoneVerified;
  final bool biometricEnabled;
  final String? pin;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  
  // Trading Details
  final String? clientCode;
  final String? dpId;
  final String? boid;
  final List<String> segments; // Equity, FO, Currency, Commodity
  
  // Bank Details
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;
  
  // Preferences
  final bool darkMode;
  final bool notificationsEnabled;
  final bool biometricLogin;
  
  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.photoUrl,
    required this.emailVerified,
    required this.phoneVerified,
    required this.biometricEnabled,
    this.pin,
    required this.createdAt,
    this.lastLoginAt,
    this.clientCode,
    this.dpId,
    this.boid,
    this.segments = const [],
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.darkMode = true,
    this.notificationsEnabled = true,
    this.biometricLogin = false,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photoUrl: json['photoUrl'] as String?,
      emailVerified: json['emailVerified'] as bool,
      phoneVerified: json['phoneVerified'] as bool,
      biometricEnabled: json['biometricEnabled'] as bool,
      pin: json['pin'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] != null 
          ? DateTime.parse(json['lastLoginAt'] as String) 
          : null,
      clientCode: json['clientCode'] as String?,
      dpId: json['dpId'] as String?,
      boid: json['boid'] as String?,
      segments: (json['segments'] as List<dynamic>?)?.cast<String>() ?? [],
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      ifscCode: json['ifscCode'] as String?,
      darkMode: json['darkMode'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      biometricLogin: json['biometricLogin'] as bool? ?? false,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'biometricEnabled': biometricEnabled,
      'pin': pin,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'clientCode': clientCode,
      'dpId': dpId,
      'boid': boid,
      'segments': segments,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'darkMode': darkMode,
      'notificationsEnabled': notificationsEnabled,
      'biometricLogin': biometricLogin,
    };
  }
  
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? photoUrl,
    bool? emailVerified,
    bool? phoneVerified,
    bool? biometricEnabled,
    String? pin,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    String? clientCode,
    String? dpId,
    String? boid,
    List<String>? segments,
    String? bankName,
    String? accountNumber,
    String? ifscCode,
    bool? darkMode,
    bool? notificationsEnabled,
    bool? biometricLogin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      pin: pin ?? this.pin,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      clientCode: clientCode ?? this.clientCode,
      dpId: dpId ?? this.dpId,
      boid: boid ?? this.boid,
      segments: segments ?? this.segments,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      darkMode: darkMode ?? this.darkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      biometricLogin: biometricLogin ?? this.biometricLogin,
    );
  }
}
