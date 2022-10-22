// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      json['id'] as String?,
      json['label'] as String,
      json['createdTime'] as int,
      json['updatedTime'] as int,
      json['parentId'] as String,
      json['icon'] as String,
      json['isFolder'] as bool,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'createdTime': instance.createdTime,
      'updatedTime': instance.updatedTime,
      'parentId': instance.parentId,
      'icon': instance.icon,
      'isFolder': instance.isFolder,
    };
