import 'package:freezed_annotation/freezed_annotation.dart';

part 'pieces.freezed.dart';

@freezed
class Pieces with _$Pieces {
  factory Pieces({
    required int largeur,
    required int longueur,
    required int hauteur,
  }) = _Pieces;
}