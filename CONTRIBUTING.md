# Contributing to NovaHealth

First off, thank you for considering contributing to NovaHealth! 🎉

It's people like you that make NovaHealth such a great tool for health and wellness tracking.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Workflow](#development-workflow)
- [Style Guidelines](#style-guidelines)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/yourusername/nova-health.git
   cd nova-health
   ```
3. **Set up your development environment**:
   ```bash
   flutter pub get
   ```
4. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates.

When creating a bug report, include:
- Clear and descriptive title
- Steps to reproduce the bug
- Expected behavior
- Actual behavior
- Screenshots (if applicable)
- Device/Platform information
- App version

**Template:**
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Platform:**
- Device: [e.g. iPhone 13, Samsung Galaxy S21]
- OS: [e.g. iOS 16, Android 13]
- App Version: [e.g. 1.0.0]
```

### 💡 Suggesting Features

Feature suggestions are tracked as GitHub issues. When creating a feature suggestion:
- Use a clear and descriptive title
- Provide detailed description of the proposed feature
- Explain why this feature would be useful
- List any alternatives you've considered

### 🔧 Code Contributions

#### Areas for Contribution

- **Frontend**: Flutter UI/UX improvements
- **Backend**: ML models, API enhancements
- **Documentation**: Improve docs, add examples
- **Tests**: Increase test coverage
- **Translations**: Add new languages
- **Accessibility**: Improve app accessibility

## Development Workflow

### 1. Set Up Development Environment

```bash
# Ensure Flutter is installed
flutter doctor

# Install dependencies
flutter pub get

# Run tests to ensure everything works
flutter test
```

### 2. Make Changes

- Write clear, readable code
- Follow the style guidelines (see below)
- Add tests for new features
- Update documentation

### 3. Test Your Changes

```bash
# Run tests
flutter test

# Check code quality
flutter analyze

# Format code
dart format .

# Test on actual devices/emulators
flutter run -d chrome      # Web
flutter run -d android     # Android
```

### 4. Commit Changes

```bash
git add .
git commit -m "Add: Your descriptive commit message"
```

### 5. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then go to GitHub and create a Pull Request.

## Style Guidelines

### Dart/Flutter Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` before committing
- Maximum line length: 80 characters
- Use meaningful variable names
- Add comments for complex logic
- Organize imports (dart, package, relative)

**Example:**
```dart
// Good
final int userAge = 25;
final String userName = 'John Doe';

// Bad
final int a = 25;
final String n = 'John Doe';
```

### Python Code Style

- Follow [PEP 8](https://pep8.org/)
- Use type hints
- Maximum line length: 100 characters
- Add docstrings for functions/classes

**Example:**
```python
def calculate_bmi(weight: float, height: float) -> float:
    """
    Calculate Body Mass Index.
    
    Args:
        weight: Weight in kilograms
        height: Height in meters
        
    Returns:
        BMI value as float
    """
    return weight / (height ** 2)
```

### File Organization

```
lib/
├── config/       # Configuration files
├── models/       # Data models
├── pages/        # UI screens
├── providers/    # State management
├── services/     # Business logic
├── utils/        # Helper functions
└── widgets/      # Reusable components
```

## Commit Guidelines

### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

### Types

- **Add**: New features
- **Fix**: Bug fixes
- **Update**: Changes to existing features
- **Refactor**: Code refactoring
- **Docs**: Documentation changes
- **Style**: Code style changes (formatting)
- **Test**: Adding or updating tests
- **Chore**: Maintenance tasks

### Examples

```bash
# Good commit messages
Add: Voice logging for sugar intake
Fix: Crash when syncing offline data
Update: Improve ML prediction accuracy
Docs: Add API documentation
Refactor: Simplify database service

# Bad commit messages
update stuff
fix bug
changes
WIP
```

### Commit Message Body (Optional)

Provide additional context:
```
Add: Voice logging for sugar intake

- Integrated speech_to_text package
- Added keyword mapping for common foods
- Implemented offline fallback

Closes #123
```

## Pull Request Process

### Before Submitting

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] Added tests for new features
- [ ] Updated documentation
- [ ] No merge conflicts with main branch
- [ ] Descriptive PR title and description

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
How has this been tested?

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes
```

### Review Process

1. Maintainers will review your PR
2. Address any requested changes
3. Once approved, your PR will be merged
4. Your contribution will be credited!

## Recognition

Contributors will be:
- Added to the Contributors section
- Mentioned in release notes
- Credited in app's About section (for significant contributions)

## Questions?

Feel free to:
- Open a GitHub issue
- Start a discussion in GitHub Discussions
- Reach out to maintainers

---

Thank you for contributing to NovaHealth! 🙏

Every contribution, no matter how small, makes a difference.
