import 'formatters.dart';

class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Please enter a valid email address';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (value.length > 128) return 'Password must be at most 128 characters';
    if (!RegExp('[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }
    if (!RegExp('[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }
    if (!RegExp('[0-9]').hasMatch(value)) {
      return 'Password must contain a digit';
    }
    if (!RegExp('[^A-Za-z0-9]').hasMatch(value)) {
      return 'Password must contain a special character';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? name(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (value.trim().length > 40) {
      return '$fieldName must be at most 40 characters';
    }
    return null;
  }

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }

  static String? vin(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!isValidVin(value)) {
      return 'VIN must be 17 characters (letters and numbers, no I, O, Q)';
    }
    return null;
  }

  static String? mileage(String? value) {
    if (value == null || value.isEmpty) return null;
    final num = int.tryParse(value);
    if (num == null || num < 0) return 'Mileage must be a non-negative number';
    return null;
  }

  static String? year(String? value) {
    if (value == null || value.isEmpty) return 'Year is required';
    final num = int.tryParse(value);
    if (num == null || num < 1900 || num > 2099) {
      return 'Year must be between 1900 and 2099';
    }
    return null;
  }

  static String? positiveNumber(String? value, {String fieldName = 'Value'}) {
    if (value == null || value.isEmpty) return null;
    final num = double.tryParse(value);
    if (num == null || num < 0) {
      return '$fieldName must be a non-negative number';
    }
    return null;
  }
}

class FormValidator {
  final Map<String, String?> _errors = {};
  final Map<String, String? Function(String?)> _validators;

  FormValidator(this._validators);

  void validate(String field, String? value) {
    final validator = _validators[field];
    if (validator != null) {
      _errors[field] = validator(value);
    }
  }

  void validateAll(Map<String, String?> values) {
    _errors.clear();
    for (final entry in values.entries) {
      validate(entry.key, entry.value);
    }
  }

  bool get isValid => _errors.values.every((e) => e == null);

  String? error(String field) => _errors[field];

  Map<String, String?> get errors => Map.unmodifiable(_errors);

  void clear() => _errors.clear();
}
