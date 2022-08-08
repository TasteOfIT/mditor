import 'package:joplin_database/database/database.dart';

abstract class LocalDataSource {
  LocalDataSource(JoplinDatabase database) : _database = database;
  final JoplinDatabase _database;

  JoplinDatabase get database => _database;
}
