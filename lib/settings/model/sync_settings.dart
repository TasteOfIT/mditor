import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sync_settings.g.dart';

@JsonSerializable()
class SyncSettings extends Equatable {
  const SyncSettings({
    this.serverUrl = '',
    this.email = '',
    this.password = '',
    this.interval = Interval.disable,
  });

  final String serverUrl;
  final String email;
  final String password;
  final Interval interval;

  bool isSet() {
    return serverUrl.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }

  static SyncSettings fromJson(Map<String, dynamic> json) {
    return _$SyncSettingsFromJson(json);
  }

  SyncSettings copyWith({
    String? serverUrl,
    String? email,
    String? password,
    Interval? interval,
  }) {
    return SyncSettings(
      serverUrl: serverUrl ?? this.serverUrl,
      email: email ?? this.email,
      password: password ?? this.password,
      interval: interval ?? this.interval,
    );
  }

  Map<String, dynamic> toJson() {
    return _$SyncSettingsToJson(this);
  }

  @override
  List<Object?> get props => [serverUrl, email, password, interval];
}

enum Interval {
  disable,
  fiveMinutes,
  tenMinutes,
  halfHour,
  oneHour,
  twelveHours,
  oneDay;
}
