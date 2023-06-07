class FavoriteSelectionDto {
  FavoriteSelectionDto({
      required this.section,
      required this.isSelected,});

  FavoriteSelectionDto.fromJson(dynamic json) {
    section = json['section'];
    isSelected = json['isSelected'];
  }
  String? section;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['section'] = section;
    map['isSelected'] = isSelected;
    return map;
  }

}