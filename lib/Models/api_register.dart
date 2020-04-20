import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part  'api_register.g.dart';

@JsonSerializable()
class Register
{
String email;
String password;
String fullName;

 Register({
  @required this.email,
  @required this.password,
    @required this.fullName,
  });

 Map<String,dynamic> tojson() => _$RegisterToJson(this);

 factory Register.fromJson(Map<String,dynamic> item) => _$RegisterFromJson(item);
}