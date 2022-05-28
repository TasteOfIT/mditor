import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static Future<Storage> createStorage() async {
    return HydratedStorage.build(
      storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
    );
  }
}
