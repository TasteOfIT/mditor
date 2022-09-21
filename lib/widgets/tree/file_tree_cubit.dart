import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'file.dart';

class FileTreeCubit extends Cubit<List<FileNode>> {
  FileTreeCubit() : super(const []);

  void update(List<FileNode> nodes) => emit(nodes);
}
