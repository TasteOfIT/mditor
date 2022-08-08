import 'package:flutter_modular/flutter_modular.dart';
import 'package:joplin_database/database/database.dart';

import '../repository/note_repository.dart';
import '../repository/notebook_repository.dart';

class DataModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => NotebookRepository(Modular.get<JoplinDatabase>()), export: true),
        Bind.lazySingleton((i) => NoteRepository(Modular.get<JoplinDatabase>()), export: true),
      ];
}
