// ignore_for_file: non_constant_identifier_names

import 'package:my_mobile_app/config/development_env.dart';
import 'package:my_mobile_app/config/production_env.dart';
import 'package:my_mobile_app/config/staging_env.dart';
import 'package:my_mobile_app/flavors.dart';

abstract class EnvFields {
  abstract final String BASE_URL;
  abstract final String API_KEY;
  abstract final String API_SECRET;
}

abstract class Env implements EnvFields {
  
  factory Env() => _instance();

  // static const Env _instance = F.appFlavor ? DebugEnv() : ReleaseEnv();
  static Env _instance() {
    switch (F.appFlavor) {
      case Flavor.PRODUCTION:
        return ProductionEnv();
      case Flavor.DEVELOPMENT:
        return DevelopmentEnv();
      case Flavor.STAGING:
        return StagingEnv();
    }
  }
}
