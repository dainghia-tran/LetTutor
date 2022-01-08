import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/models/token.dart';

part 'tokens.g.dart';

@JsonSerializable(explicitToJson: true)
class Tokens {
  Token? access;
  Token? refresh;
  Tokens();
  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
  Map<String, dynamic> toJson() => _$TokensToJson(this);
}
