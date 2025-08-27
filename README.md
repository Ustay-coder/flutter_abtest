<!--
This README describes the flutter_abtest package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# flutter_abtest

A Flutter package for implementing UI A/B testing in your Flutter applications. This library allows you to display different UI variations with specified probabilities, making it easy to conduct A/B tests for user interface elements.

## Features

- **Simple A/B Testing**: Easily implement A/B tests with multiple UI variations
- **Probability-based Selection**: Define custom probabilities for each UI variation
- **Flexible Widget Creation**: Support both direct widgets and widget builders
- **Error Handling**: Comprehensive error handling for invalid configurations
- **Lightweight**: Minimal dependencies, only requires Flutter SDK

## Getting started

### Installation

Add `flutter_abtest` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_abtest: ^0.0.1
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:flutter_abtest/flutter_abtest.dart';
```

## Usage

### Basic Usage

The package provides a simple way to implement A/B testing with multiple UI variations. Here's how to use it:

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A/B Test Example')),
      body: Center(
        child: ABTestManager.testUI([
          // UI A - 50% probability
          ABTestUnit.widget(
            probability: 0.5,
            widget: Container(
              color: Colors.blue,
              child: Text('UI Variation A'),
            ),
          ),
          // UI B - 50% probability
          ABTestUnit.widget(
            probability: 0.5,
            widget: Container(
              color: Colors.red,
              child: Text('UI Variation B'),
            ),
          ),
        ]),
      ),
    );
  }
}
```

### Using Widget Builders

For more complex widgets or when you need dynamic content, use widget builders:

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A/B Test with Builders')),
      body: Center(
        child: ABTestManager.testUI([
          // UI A - 30% probability
          ABTestUnit.builder(
            probability: 0.3,
            widgetBuilder: () => Container(
              color: Colors.green,
              child: Text('UI Variation A (30%)'),
            ),
          ),
          // UI B - 40% probability
          ABTestUnit.builder(
            probability: 0.4,
            widgetBuilder: () => Container(
              color: Colors.orange,
              child: Text('UI Variation B (40%)'),
            ),
          ),
          // UI C - 30% probability
          ABTestUnit.builder(
            probability: 0.3,
            widgetBuilder: () => Container(
              color: Colors.purple,
              child: Text('UI Variation C (30%)'),
            ),
          ),
        ]),
      ),
    );
  }
}
```

### Advanced Example with Multiple Variations

```dart
class AdvancedABTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Advanced A/B Test')),
      body: Column(
        children: [
          // Header variation
          ABTestManager.testUI([
            ABTestUnit.widget(
              probability: 0.6,
              widget: Text(
                'Welcome to our app!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ABTestUnit.widget(
              probability: 0.4,
              widget: Text(
                'Hello there!',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ]),
          
          SizedBox(height: 20),
          
          // Button variation
          ABTestManager.testUI([
            ABTestUnit.builder(
              probability: 0.5,
              widgetBuilder: () => ElevatedButton(
                onPressed: () {},
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            ABTestUnit.builder(
              probability: 0.5,
              widgetBuilder: () => OutlinedButton(
                onPressed: () {},
                child: Text('Begin'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
```

## API Reference

### ABTestManager

The main class for managing A/B tests.

#### Methods

- `static Widget testUI(List<ABTestUnit> units)`
  - Takes a list of `ABTestUnit` objects and returns a widget based on probability
  - Throws an exception if the units list is empty
  - Throws an exception if the total probability exceeds 1.0

### ABTestUnit

Represents a single UI variation in an A/B test.

#### Constructors

- `ABTestUnit.widget({required double probability, required Widget widget})`
  - Creates a unit with a direct widget
  - `probability`: The probability of this variation being selected (0.0 to 1.0)
  - `widget`: The widget to display

- `ABTestUnit.builder({required double probability, required Widget Function() widgetBuilder})`
  - Creates a unit with a widget builder function
  - `probability`: The probability of this variation being selected (0.0 to 1.0)
  - `widgetBuilder`: A function that returns the widget to display

- `ABTestUnit({required double probability, required Widget widget})`
  - Legacy constructor for backward compatibility

#### Methods

- `Widget getWidget()`
  - Returns the widget for this unit
  - Throws an exception if neither widget nor widgetBuilder is set

## Important Notes

1. **Probability Sum**: The sum of all probabilities should equal 1.0. If it exceeds 1.0, an exception will be thrown.

2. **Probability Validation**: If the total probability is less than 1.0, a warning will be printed and the last unit will be returned as a fallback.

3. **Random Selection**: The selection is based on `Random().nextDouble()` from Dart's `dart:math` library.

4. **Error Handling**: The package includes comprehensive error handling for common issues like empty unit lists and invalid probabilities.

## Additional information

### Contributing

Feel free to contribute to this package by:
- Reporting bugs
- Suggesting new features
- Submitting pull requests

### Issues

If you encounter any issues or have questions, please file an issue on the package repository.

### License

This package is licensed under the same license as Flutter.
