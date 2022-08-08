import 'package:joplin_database/database/database.dart';

import '../utils/extensions.dart';

class Notebook {
  final String? id;
  final String title;
  final int createdTime;
  final int updatedTime;
  final int userCreatedTime;
  final int userUpdatedTime;
  final String encryptionCipherText;
  final bool encryptionApplied;
  final String parentId;
  final bool isShared;
  final String shareId;
  final String masterKeyId;
  final String icon;

  Notebook({
    this.id,
    required this.title,
    required this.createdTime,
    required this.updatedTime,
    this.encryptionCipherText = '',
    this.encryptionApplied = false,
    this.parentId = '',
    this.isShared = false,
    this.shareId = '',
    this.masterKeyId = '',
    this.icon = '',
  })  : userCreatedTime = createdTime,
        userUpdatedTime = updatedTime;

  Notebook.from(Folder folder)
      : id = folder.id,
        title = folder.title,
        createdTime = folder.createdTime,
        updatedTime = folder.updatedTime,
        userCreatedTime = folder.userCreatedTime,
        userUpdatedTime = folder.userUpdatedTime,
        encryptionCipherText = folder.encryptionCipherText,
        encryptionApplied = folder.encryptionApplied.toBool(),
        parentId = folder.parentId,
        isShared = folder.isShared.toBool(),
        shareId = folder.shareId,
        masterKeyId = folder.masterKeyId,
        icon = folder.icon;

  Folder to() {
    return Folder(
      title: title,
      createdTime: createdTime,
      updatedTime: updatedTime,
      userCreatedTime: userCreatedTime,
      userUpdatedTime: userUpdatedTime,
      encryptionCipherText: encryptionCipherText,
      encryptionApplied: encryptionApplied.toInt(),
      parentId: parentId,
      isShared: isShared.toInt(),
      shareId: shareId,
      masterKeyId: masterKeyId,
      icon: icon,
    );
  }
}
