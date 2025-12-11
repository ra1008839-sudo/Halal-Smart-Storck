class Validators {
  // Email Validator
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
  
  // Password Validator (min 8 chars, at least 1 uppercase, 1 lowercase, 1 number)
  static bool isValidPassword(String password) {
    if (password.length < 8) return false;
    
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    
    return hasUppercase && hasLowercase && hasDigit;
  }
  
  // Phone Number Validator (10 digits)
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(phone);
  }
  
  // Username Validator (3-20 chars, alphanumeric and underscore)
  static bool isValidUsername(String username) {
    if (username.length < 3 || username.length > 20) return false;
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    return usernameRegex.hasMatch(username);
  }
  
  // PAN Card Validator
  static bool isValidPAN(String pan) {
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegex.hasMatch(pan);
  }
  
  // Aadhar Number Validator (12 digits)
  static bool isValidAadhar(String aadhar) {
    final aadharRegex = RegExp(r'^[0-9]{12}$');
    return aadharRegex.hasMatch(aadhar);
  }
  
  // Amount Validator (positive number)
  static bool isValidAmount(String amount) {
    try {
      final value = double.parse(amount);
      return value > 0;
    } catch (e) {
      return false;
    }
  }
  
  // Stock Symbol Validator (3-10 uppercase letters)
  static bool isValidStockSymbol(String symbol) {
    final symbolRegex = RegExp(r'^[A-Z]{3,10}$');
    return symbolRegex.hasMatch(symbol);
  }
  
  // UPI ID Validator
  static bool isValidUPI(String upi) {
    final upiRegex = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+$');
    return upiRegex.hasMatch(upi);
  }
  
  // Empty String Validator
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
  
  // Min Length Validator
  static bool hasMinLength(String value, int minLength) {
    return value.length >= minLength;
  }
  
  // Max Length Validator
  static bool hasMaxLength(String value, int maxLength) {
    return value.length <= maxLength;
  }
  
  // Numeric Validator
  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
  
  // Password Match Validator
  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }
  
  // Get Email Error Message
  static String? getEmailError(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!isValidEmail(email)) return 'Invalid email format';
    return null;
  }
  
  // Get Password Error Message
  static String? getPasswordError(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }
  
  // Get Phone Error Message
  static String? getPhoneError(String phone) {
    if (phone.isEmpty) return 'Phone number is required';
    if (!isValidPhoneNumber(phone)) return 'Invalid phone number (10 digits required)';
    return null;
  }
}
