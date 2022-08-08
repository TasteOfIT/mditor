import 'package:joplin_database/database/database.dart';

import '../local_data_source.dart';
import '../models/note_item.dart';
import '../utils/date_utils.dart';

class NoteRepository extends LocalDataSource {
  NoteRepository(JoplinDatabase database) : super(database);

  Stream<List<NoteItem>> getNotes() {
    return database.noteDao.getNotes().map((event) {
      return event.map((element) => NoteItem.from(element)).toList();
    });
  }

  Future<int> addNote(String parentId, String title, String body) {
    int currentTime = DateUtils.currentTimestamp();
    final noteItem = NoteItem(
      parentId: parentId,
      title: title,
      body: body,
      createdTime: currentTime,
      updatedTime: currentTime,
      markupLanguage: MarkupLanguage.markdown,
    );
    return database.noteDao.addNote(noteItem.to());
  }

  Future<int> removeNote(String id) {
    return database.noteDao.removeNote(id);
  }
}
