import 'package:common/common.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static Future<Storage> createStorage() async {
    return await HydratedStorage.build(
      storageDirectory: isWeb ? HydratedStorage.webStorageDirectory : await getApplicationSupportDirectory(),
    );
  }
}
