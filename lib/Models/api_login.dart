import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part  'api_login.g.dart';

@JsonSerializable()
class Login
{
String email;
String password;

 Login({
  @required this.email,
  @required this.password,
  });

 Map<String,dynamic> tojson() => _$LoginToJson(this);
}