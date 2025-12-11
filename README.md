# Halal Smart Stock 📈

**Advanced Halal Stock Trading App with Algo Trading Bot**

> Trade Smarter, Stay Halal

## 🌟 Features

### Core Features
- **Halal Stock Screening**: Access to 500+ Shariah-compliant stocks
- **Real-time Market Data**: Live stock prices and market indices
- **Advanced Charting**: Technical analysis with multiple indicators
- **Watchlist Management**: Track your favorite stocks
- **Portfolio Management**: Monitor your investments and P&L

### Trading Features
- **Algo Trading Bot**: Automated trading with AI-powered signals
- **Risk Management**: 2% max loss per trade rule
- **Trailing Stop Loss**: Dynamic stop loss (0.5% - 10%)
- **Technical Indicators**:
  - RSI (Relative Strength Index)
  - MACD (Moving Average Convergence Divergence)
  - Bollinger Bands
  - Moving Averages (SMA, EMA, WMA)

### Additional Services
- **F&O Trading**: Futures and Options (Coming Soon)
- **Mutual Funds**: Shariah-compliant investment funds
- **UPI Payments**: Instant money transfer and bill payments
- **Islamic Loans**: Interest-free financing options

## 🎨 Design

Built with **Groww-style dark theme** for optimal trading experience:
- **Primary Background**: `#0A0E27` (Navy Black)
- **Card Background**: `#1A1F3C`
- **Accent Green**: `#00D09C` (Groww Green)
- **Accent Red**: `#FF5252`

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart 3.10.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ra1008839-sudo/Halal-Smart-Storck.git
cd Halal-Smart-Storck
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build APK
```bash
flutter build apk --release
```

## 📁 Project Structure

```
lib/
├── config/                 # App configuration
│   ├── app_config.dart
│   ├── theme_config.dart
│   ├── api_config.dart
│   └── routes.dart
├── core/                   # Core utilities
│   ├── constants/
│   └── utils/
├── data/                   # Data layer
│   ├── models/
│   └── static/
├── presentation/           # UI layer
│   ├── providers/          # State management
│   ├── screens/            # App screens
│   └── widgets/            # Reusable widgets
├── algo/                   # Algo trading bot
│   ├── algo_engine.dart
│   ├── risk_manager.dart
│   ├── trailing_stop_loss.dart
│   └── signal_generator.dart
├── indicators/             # Technical indicators
│   ├── rsi_calculator.dart
│   ├── macd_calculator.dart
│   ├── bollinger_calculator.dart
│   └── moving_average_calculator.dart
└── main.dart              # App entry point
```

## 🛠️ Technology Stack

- **Framework**: Flutter 3.38.4
- **Language**: Dart 3.10.3
- **State Management**: Provider
- **UI Components**: Material Design
- **Fonts**: Google Fonts (Inter)
- **Charts**: FL Chart
- **Storage**: Shared Preferences
- **Networking**: Dio
- **WebSockets**: web_socket_channel

## 📊 Technical Indicators

### RSI (Relative Strength Index)
- Period: 14
- Overbought: > 70
- Oversold: < 30

### MACD (Moving Average Convergence Divergence)
- Fast Period: 12
- Slow Period: 26
- Signal Period: 9

### Bollinger Bands
- Period: 20
- Standard Deviations: 2

## 🔐 Security & Compliance

- **Halal Certified**: All stocks are Shariah-compliant
- **No Interest**: Interest-free trading and financing
- **Data Privacy**: User data encrypted and secure
- **Regulatory Compliance**: SEBI guidelines followed

## 📱 Screenshots

(Screenshots will be added after app is built and tested)

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines before submitting a PR.

## 📄 License

This project is licensed under the MIT License.

## 📧 Contact

- **Developer**: Halal Smart Stock Team
- **Email**: support@halalsmartstock.com
- **Website**: https://halalsmartstock.com

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Groww for design inspiration
- Islamic Finance Community for guidance

---

**Made with ❤️ for the Muslim Trading Community**
