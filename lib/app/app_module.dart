import 'package:flutter_modular/flutter_modular.dart';
import 'package:joplin_database/joplin_database.dart';

import 'app_routes.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        DatabaseModule(),
      ];

  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => Routes.get();
}
