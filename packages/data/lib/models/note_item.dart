import 'package:joplin_database/database/database.dart';

import '../utils/const.dart';
import '../utils/extensions.dart';

class NoteItem {
  final String? id;
  final String parentId;
  final String title;
  final String body;
  final int createdTime;
  final int updatedTime;
  final bool isConflict;
  final double latitude;
  final double longitude;
  final double altitude;
  final String author;
  final String sourceUrl;
  final bool isTodo;
  final int todoDue;
  final int todoCompleted;
  final String source;
  final String sourceApplication;
  final String applicationData;
  final double order;
  final int userCreatedTime;
  final int userUpdatedTime;
  final String encryptionCipherText;
  final bool encryptionApplied;
  final MarkupLanguage markupLanguage;
  final bool isShared;
  final String shareId;
  final String conflictOriginalId;
  final String masterKeyId;

  NoteItem({
    this.id,
    required this.parentId,
    required this.title,
    required this.body,
    required this.createdTime,
    required this.updatedTime,
    this.isConflict = false,
    this.latitude = 0,
    this.longitude = 0,
    this.altitude = 0,
    this.author = '',
    this.sourceUrl = '',
    this.isTodo = false,
    this.todoDue = 0,
    this.todoCompleted = 0,
    this.source = Const.appName,
    this.sourceApplication = Const.appPackage,
    this.applicationData = '',
    this.order = 0,
    this.encryptionCipherText = '',
    this.encryptionApplied = false,
    this.markupLanguage = MarkupLanguage.unknown,
    this.isShared = false,
    this.shareId = '',
    this.conflictOriginalId = '',
    this.masterKeyId = '',
  })  : userCreatedTime = createdTime,
        userUpdatedTime = updatedTime;

  NoteItem.from(Note note)
      : id = note.id,
        parentId = note.parentId,
        title = note.title,
        body = note.body,
        createdTime = note.createdTime,
        updatedTime = note.updatedTime,
        isConflict = note.isConflict == 1,
        latitude = note.latitude,
        longitude = note.longitude,
        altitude = note.altitude,
        author = note.author,
        sourceUrl = note.sourceUrl,
        isTodo = note.isTodo == 1,
        todoDue = note.todoDue,
        todoCompleted = note.todoCompleted,
        source = note.source,
        sourceApplication = note.sourceApplication,
        applicationData = note.applicationData,
        order = note.order,
        userCreatedTime = note.userCreatedTime,
        userUpdatedTime = note.userUpdatedTime,
        encryptionCipherText = note.encryptionCipherText,
        encryptionApplied = note.encryptionApplied == 1,
        markupLanguage = MarkupLanguage.valueOf(note.markupLanguage),
        isShared = note.isShared == 1,
        shareId = note.shareId,
        conflictOriginalId = note.conflictOriginalId,
        masterKeyId = note.masterKeyId;

  Note to() {
    return Note(
      parentId: parentId,
      title: title,
      body: body,
      createdTime: createdTime,
      updatedTime: updatedTime,
      isConflict: isConflict.toInt(),
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
      author: author,
      sourceUrl: sourceUrl,
      isTodo: isTodo.toInt(),
      todoDue: todoDue,
      todoCompleted: todoCompleted,
      source: source,
      sourceApplication: sourceApplication,
      applicationData: applicationData,
      order: order,
      userCreatedTime: userCreatedTime,
      userUpdatedTime: userUpdatedTime,
      encryptionCipherText: encryptionCipherText,
      encryptionApplied: encryptionApplied.toInt(),
      markupLanguage: markupLanguage.index,
      isShared: isShared.toInt(),
      shareId: shareId,
      conflictOriginalId: conflictOriginalId,
      masterKeyId: masterKeyId,
    );
  }
}

enum MarkupLanguage {
  unknown,
  markdown,
  html,
  any;

  static MarkupLanguage valueOf(int index) {
    const values = MarkupLanguage.values;
    if (index >= 0 && index < values.length) {
      return MarkupLanguage.values[index];
    } else {
      return MarkupLanguage.unknown;
    }
  }
}
