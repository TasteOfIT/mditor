import 'package:joplin_database/database/database.dart';

import '../local_data_source.dart';
import '../models/notebook.dart';
import '../utils/date_utils.dart';

class NotebookRepository extends LocalDataSource {
  NotebookRepository(JoplinDatabase database) : super(database);

  Stream<List<Notebook>> getNotebooks() {
    return database.folderDao.getFolders().map((event) {
      return event.map((element) => Notebook.from(element)).toList();
    });
  }

  Future<Notebook?> getNotebook(String id) {
    return database.folderDao.getFolder(id).then((value) {
      if (value != null) {
        return Notebook.from(value);
      } else {
        return null;
      }
    });
  }

  Stream<List<Notebook>> getNotebooksIn(String parentId) {
    return database.folderDao.foldersIn(parentId).map((event) {
      return event.map((element) => Notebook.from(element)).toList();
    });
  }

  Future<String> addNotebook(String title, String? parentId) {
    int currentTime = DateUtils.currentTimestamp();
    Notebook notebook = Notebook(
      title: title,
      parentId: parentId ?? '',
      createdTime: currentTime,
      updatedTime: currentTime,
    );
    return database.folderDao.addFolder(notebook.to());
  }

  Future<int> updateNotebook(String id, String title) {
    int currentTime = DateUtils.currentTimestamp();
    return database.folderDao.editFolder(id, title, currentTime);
  }

  Future<int> moveNotebook(String id, String parentId) {
    int currentTime = DateUtils.currentTimestamp();
    return database.folderDao.moveToFolder(id, parentId, currentTime);
  }

  Future<int> removeNotebook(String id) {
    return database.folderDao.removeFolder(id);
  }
}
