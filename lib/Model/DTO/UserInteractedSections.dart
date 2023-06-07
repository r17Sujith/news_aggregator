class UserInteractedSections {
  UserInteractedSections({
    String? section,
    int? numOfClicks,
  }) {
    _section = section;
    _numOfClicks = numOfClicks;
  }
  String? _section;

  String? get section => _section;

  set section(String? value) {
    _section = value;
  }

  int? _numOfClicks=0;
  UserInteractedSections.fromJson(dynamic json) {
    if (json['section'] != null) {
      section = json['section'];
    }
    if (json['numOfClicks'] != null) {
      numOfClicks = json['numOfClicks'];
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['section'] = section;
    map['numOfClicks'] = numOfClicks;
    return map;
  }

  int? get numOfClicks => _numOfClicks;

  set numOfClicks(int? value) {
    _numOfClicks = value;
  }
}
