import 'package:flutter_modular/flutter_modular.dart';

import 'app_routes.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => Routes.get();
}
