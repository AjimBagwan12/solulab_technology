// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flower_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flower _$FlowerFromJson(Map<String, dynamic> json) {
  return Flower(
    name: json['name'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$FlowerToJson(Flower instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
};
