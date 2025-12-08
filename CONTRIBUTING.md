# Contributing to Halal Smart Stock

Thank you for your interest in contributing to Halal Smart Stock! This document provides guidelines and information for contributors.

## 🎯 Project Vision

Halal Smart Stock is a production-ready, advanced trading application that:
- Provides Sharia-compliant stock trading
- Features intelligent algo trading with risk management
- Offers professional-grade technical analysis
- Maintains Groww-inspired user experience

## 🏗️ Architecture Guidelines

### Clean Architecture Principles
1. **Separation of Concerns**: Keep presentation, business logic, and data layers separate
2. **Dependency Rule**: Dependencies point inward (UI → Domain → Data)
3. **Testability**: All components should be testable in isolation

### Code Organization
```
lib/
├── config/          # App configuration
├── core/            # Core utilities, constants
├── data/            # Models, repositories, data sources
├── domain/          # Business logic, use cases
├── presentation/    # UI, screens, widgets
├── services/        # External services
├── algo/            # Trading bot logic
└── indicators/      # Technical indicators
```

## 💻 Development Workflow

### 1. Setting Up Development Environment

```bash
# Clone the repository
git clone https://github.com/ra1008839-sudo/Halal-Smart-Storck.git
cd Halal-Smart-Storck/flutter_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### 2. Branch Naming Convention

- **Feature**: `feature/feature-name`
- **Bug Fix**: `fix/bug-description`
- **Enhancement**: `enhance/feature-name`
- **Documentation**: `docs/what-changed`

### 3. Commit Message Format

```
type(scope): subject

body

footer
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

**Example**:
```
feat(algo): implement trailing stop loss with dynamic adjustment

- Added TrailingStopLoss class with calculation methods
- Implemented breakeven stop loss feature
- Added volatility-based recommendations
- Created simulation function for backtesting

Closes #123
```

## 🎨 Code Style Guidelines

### Dart Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter analyze` before committing
- Format code with `flutter format .`
- Maximum line length: 100 characters

### Naming Conventions
- **Classes**: PascalCase (`StockCard`, `AlgoEngine`)
- **Variables**: camelCase (`currentPrice`, `stopLoss`)
- **Constants**: camelCase with const (`primaryBackground`)
- **Files**: snake_case (`stock_card.dart`, `algo_engine.dart`)
- **Private members**: prefix with underscore (`_calculateRisk`)

### Documentation
- Add doc comments for all public APIs
- Include usage examples for complex functions
- Document parameters and return values

```dart
/// Calculate trailing stop loss based on current price movement.
/// 
/// Returns new stop loss price if adjustment is needed, null otherwise.
/// 
/// Parameters:
/// - [entryPrice]: The price at which position was entered
/// - [currentPrice]: The current market price
/// - [currentStopLoss]: The existing stop loss price
/// - [trailingPercent]: The trailing percentage (0.5% - 10%)
/// 
/// Example:
/// ```dart
/// final newSL = TrailingStopLoss.calculate(
///   entryPrice: 100.0,
///   currentPrice: 105.0,
///   currentStopLoss: 98.0,
///   trailingPercent: 2.0,
/// );
/// ```
double? calculate({...}) {
  // Implementation
}
```

## 🧪 Testing Guidelines

### Test Structure
```
test/
├── unit/           # Unit tests
├── widget/         # Widget tests
└── integration/    # Integration tests
```

### Writing Tests
- One test file per source file
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Aim for 80%+ code coverage

```dart
void main() {
  group('RiskManager', () {
    test('should calculate correct position size for 2% risk', () {
      // Arrange
      final riskManager = RiskManager();
      riskManager.updateAccountBalance(100000);
      
      // Act
      final positionSize = riskManager.calculatePositionSize(100.0, 98.0);
      
      // Assert
      expect(positionSize, equals(1000));
    });
  });
}
```

## 🎯 Feature Implementation Checklist

When implementing a new feature:

- [ ] Create feature branch
- [ ] Write unit tests
- [ ] Implement feature following architecture guidelines
- [ ] Add documentation
- [ ] Update README if needed
- [ ] Run `flutter analyze`
- [ ] Run `flutter test`
- [ ] Format code with `flutter format`
- [ ] Test on real device
- [ ] Create pull request
- [ ] Request code review

## 🔒 Security Guidelines

### Sensitive Data
- Never commit API keys, passwords, or secrets
- Use environment variables for configuration
- Store sensitive data in Flutter Secure Storage
- Implement proper authentication flow

### Code Security
- Validate all user inputs
- Sanitize data before display
- Use HTTPS for all API calls
- Implement proper error handling

## 📱 UI/UX Guidelines

### Design Principles
- Follow Groww-style design system
- Maintain consistency across screens
- Use theme colors from `ThemeConfig`
- Ensure responsive design for all screen sizes
- Target 60 FPS performance

### Widget Guidelines
- Keep widgets small and focused
- Extract reusable widgets
- Use `const` constructors when possible
- Minimize rebuilds with proper key usage

## 🤖 Algo Trading Guidelines

### Risk Management
- Always validate risk parameters
- Implement proper stop loss logic
- Never exceed max loss percentage (2%)
- Test trading logic thoroughly before deployment

### Technical Indicators
- Use mathematically accurate calculations
- Add proper error handling for edge cases
- Document indicator methodology
- Include signal interpretation

## 📊 Performance Guidelines

### Optimization
- Use lazy loading for lists
- Implement proper pagination
- Cache frequently accessed data
- Optimize images and assets
- Monitor memory usage

### Targets
- App launch time: < 2 seconds
- Frame rate: 60 FPS
- API response handling: < 500ms
- Smooth scrolling on all devices

## 🐛 Bug Reporting

### Bug Report Template
```markdown
**Description**
Clear description of the bug

**To Reproduce**
1. Go to '...'
2. Click on '....'
3. See error

**Expected Behavior**
What should happen

**Screenshots**
If applicable

**Environment**
- Device: [e.g., iPhone 12, Pixel 6]
- OS: [e.g., iOS 15, Android 12]
- App Version: [e.g., 1.0.0]
```

## 🔄 Pull Request Process

1. **Create PR** with clear title and description
2. **Link Issues** that the PR addresses
3. **Add Screenshots** for UI changes
4. **Pass CI/CD** checks
5. **Request Review** from maintainers
6. **Address Feedback** promptly
7. **Squash Commits** before merging

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Widget tests pass
- [ ] Manual testing completed
- [ ] Tested on real device

## Screenshots (if applicable)

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added where needed
- [ ] Documentation updated
- [ ] No warnings from analyzer
```

## 📚 Resources

### Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

### Packages
- [Provider Documentation](https://pub.dev/packages/provider)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [Syncfusion Charts](https://help.syncfusion.com/flutter/introduction/overview)

### Trading & Finance
- [Technical Analysis Basics](https://www.investopedia.com/technical-analysis-4689657)
- [Risk Management](https://www.investopedia.com/trading/risk-management/)
- [Halal Investment Guidelines](https://islamicfinanceguru.com/halal-stocks/)

## 🙏 Code of Conduct

### Our Standards
- Be respectful and inclusive
- Accept constructive criticism
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior
- Harassment or discriminatory comments
- Trolling or insulting remarks
- Publishing others' private information
- Unprofessional conduct

## 💬 Communication

- **GitHub Issues**: Bug reports, feature requests
- **Pull Requests**: Code contributions
- **Discussions**: General questions, ideas

## 📄 License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## 🎉 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Project documentation

Thank you for contributing to Halal Smart Stock! 🚀

---

**Questions?** Open an issue or start a discussion!
