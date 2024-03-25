// ignore_for_file: constant_identifier_names
enum Flavor {
  PRODUCTION,
  DEVELOPMENT,
  STAGING,
}

class F {
  static late Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'MyMobileApp';
      case Flavor.DEVELOPMENT:
        return '[DEV] MyMobileApp';
      case Flavor.STAGING:
        return '[STA] MyMobileApp';
    }
  }
}
