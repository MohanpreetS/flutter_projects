import 'package:smart_home_animation/core/shared/domain/entities/smart_device.dart';

import 'music_info.dart';

class SmartRoom {
  SmartRoom({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.temperature,
    required this.airHumidity,
    required this.lights,
    required this.airCondition,
    required this.timer,
    required this.musicInfo,
  });

  final String id;
  final String name;
  final String imageUrl;
  final double temperature;
  final double airHumidity;
  final SmartDevice lights;
  final SmartDevice airCondition;
  final SmartDevice timer;
  final MusicInfo musicInfo;

  SmartRoom copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? temperature,
    double? airHumidity,
    SmartDevice? lights,
    SmartDevice? airCondition,
    SmartDevice? timer,
    MusicInfo? musicInfo,
  }) =>
      SmartRoom(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        temperature: temperature ?? this.temperature,
        airHumidity: airHumidity ?? this.airHumidity,
        lights: lights ?? this.lights,
        airCondition: airCondition ?? this.airCondition,
        musicInfo: musicInfo ?? this.musicInfo,
        timer: timer ?? this.timer,
      );
}
