// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model/sync_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncSettings _$SyncSettingsFromJson(Map<String, dynamic> json) => SyncSettings(
      serverUrl: json['serverUrl'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      interval: $enumDecodeNullable(_$IntervalEnumMap, json['interval']) ?? Interval.disable,
    );

Map<String, dynamic> _$SyncSettingsToJson(SyncSettings instance) => <String, dynamic>{
      'serverUrl': instance.serverUrl,
      'email': instance.email,
      'password': instance.password,
      'interval': _$IntervalEnumMap[instance.interval]!,
    };

const _$IntervalEnumMap = {
  Interval.disable: 'disable',
  Interval.fiveMinutes: 'fiveMinutes',
  Interval.tenMinutes: 'tenMinutes',
  Interval.halfHour: 'halfHour',
  Interval.oneHour: 'oneHour',
  Interval.twelveHours: 'twelveHours',
  Interval.oneDay: 'oneDay',
};
