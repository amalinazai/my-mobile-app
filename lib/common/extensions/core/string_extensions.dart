extension StringExtensions on String? {
  String? truncateString([int maxLength = 4]) {
    if (this == null) {
      return null;
    }

    final substring = this!.substring(0, maxLength);

    // concatenate ellipses if the original string is longer than [maxLength]
    if (this!.length > maxLength) {
      return '$substring...';
    }

    return substring;
  }

  bool containsLowercase() {
    if (this != null) {
      return RegExp('[a-z]').hasMatch(this!);
    }

    return false;
  }

  bool containsUppercase() {
    if (this != null) {
      return RegExp('[A-Z]').hasMatch(this!);
    }

    return false;
  }

  bool containsNumbers() {
    if (this != null) {
      return RegExp(r'\d').hasMatch(this!);
    }

    return false;
  }

  bool containsSpecialChars() {
    if (this != null) {
      return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this!);
    }

    return false;
  }

  bool meetsLength(int length) {
    if (this != null) {
      return this!.length >= length;
    }

    return false;
  }

  String? getFileExtension() {
    if (this != null) {
      return '.${this!.split('.').last}';
    }

    return null;
  }

  String? get getFileName {
    if (this != null) {
      final splitStr = this!.split('/');
      return '${splitStr[splitStr.length - 2]}${splitStr.last}';
    }

    return null;
  }
}
