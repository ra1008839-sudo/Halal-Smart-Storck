import 'package:intl/intl.dart';

class Formatters {
  // Currency Formatter
  static String formatCurrency(double value, {String symbol = '₹'}) {
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return '$symbol${formatter.format(value)}';
  }
  
  // Compact Currency Formatter (1000 -> 1K, 1000000 -> 1M)
  static String formatCompactCurrency(double value, {String symbol = '₹'}) {
    if (value >= 10000000) {
      return '$symbol${(value / 10000000).toStringAsFixed(2)}Cr';
    } else if (value >= 100000) {
      return '$symbol${(value / 100000).toStringAsFixed(2)}L';
    } else if (value >= 1000) {
      return '$symbol${(value / 1000).toStringAsFixed(2)}K';
    }
    return '$symbol${value.toStringAsFixed(2)}';
  }
  
  // Number Formatter
  static String formatNumber(double value, {int decimals = 2}) {
    return value.toStringAsFixed(decimals);
  }
  
  // Percentage Formatter
  static String formatPercentage(double value, {int decimals = 2, bool includeSign = true}) {
    final sign = includeSign && value > 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(decimals)}%';
  }
  
  // Date Formatter
  static String formatDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }
  
  // Time Formatter
  static String formatTime(DateTime time, {String format = 'HH:mm'}) {
    return DateFormat(format).format(time);
  }
  
  // DateTime Formatter
  static String formatDateTime(DateTime dateTime, {String format = 'dd MMM yyyy, HH:mm'}) {
    return DateFormat(format).format(dateTime);
  }
  
  // Relative Time Formatter (e.g., "2 hours ago")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
  
  // Large Number Formatter (1000 -> 1K, 1000000 -> 1M, 1000000000 -> 1B)
  static String formatLargeNumber(double value, {int decimals = 2}) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(decimals)}B';
    } else if (value >= 10000000) {
      return '${(value / 10000000).toStringAsFixed(decimals)}Cr';
    } else if (value >= 100000) {
      return '${(value / 100000).toStringAsFixed(decimals)}L';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(decimals)}K';
    }
    return value.toStringAsFixed(decimals);
  }
  
  // Phone Number Formatter
  static String formatPhoneNumber(String phone) {
    if (phone.length == 10) {
      return '${phone.substring(0, 5)} ${phone.substring(5)}';
    }
    return phone;
  }
  
  // Stock Symbol Formatter (uppercase)
  static String formatSymbol(String symbol) {
    return symbol.toUpperCase();
  }
}
