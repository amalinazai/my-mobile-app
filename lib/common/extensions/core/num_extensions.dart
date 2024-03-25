extension NumExtensions on num? {
  String? addOrdinalToNumber() {
    if (this == null) return null;

    switch (this! % 100) {
      case 11:
      case 12:
      case 13:
        return '${this}th';
      default:
        switch (this! % 10) {
          case 1:
            return '${this}st';
          case 2:
            return '${this}nd';
          case 3:
            return '${this}rd';
          default:
            return '${this}th';
        }
    }
  }

  num? convertBytesToMb() {
    if (this == null) return null;

    return this! / 1024 / 1024;
  }

  num? convertMbToBytes() {
    if (this == null) return null;

    return this! * 1024 * 1024;
  }
}
