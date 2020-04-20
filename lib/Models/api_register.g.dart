// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register(
    email: json['email'] as String,
    password: json['password'] as String,
    fullName: json['FullName'] as String,
  );
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'Email': instance.email,
      'Password': instance.password,
      'FullName': instance.fullName,
    };
