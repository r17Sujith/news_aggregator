class NewsResponse {
  NewsResponse({
      Response? response,}){
    _response = response;
}

  NewsResponse.fromJson(dynamic json) {
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  Response? _response;

  Response? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }

}

class Response {
  Response({
      String? status, 
      String? userTier, 
      num? total, 
      num? startIndex, 
      num? pageSize, 
      num? currentPage, 
      num? pages, 
      String? orderBy, 
      List<Results>? results,}){
    _status = status;
    _userTier = userTier;
    _total = total;
    _startIndex = startIndex;
    _pageSize = pageSize;
    _currentPage = currentPage;
    _pages = pages;
    _orderBy = orderBy;
    _results = results;
}

  Response.fromJson(dynamic json) {
    _status = json['status'];
    _userTier = json['userTier'];
    _total = json['total'];
    _startIndex = json['startIndex'];
    _pageSize = json['pageSize'];
    _currentPage = json['currentPage'];
    _pages = json['pages'];
    _orderBy = json['orderBy'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  String? _status;
  String? _userTier;
  num? _total;
  num? _startIndex;
  num? _pageSize;
  num? _currentPage;
  num? _pages;
  String? _orderBy;
  List<Results>? _results;

  String? get status => _status;
  String? get userTier => _userTier;
  num? get total => _total;
  num? get startIndex => _startIndex;
  num? get pageSize => _pageSize;
  num? get currentPage => _currentPage;
  num? get pages => _pages;
  String? get orderBy => _orderBy;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['userTier'] = _userTier;
    map['total'] = _total;
    map['startIndex'] = _startIndex;
    map['pageSize'] = _pageSize;
    map['currentPage'] = _currentPage;
    map['pages'] = _pages;
    map['orderBy'] = _orderBy;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      String? id, 
      String? type, 
      String? sectionId, 
      String? sectionName, 
      String? webPublicationDate, 
      String? webTitle, 
      String? webUrl, 
      String? apiUrl, 
      Fields? fields, 
      bool? isHosted, 
      String? pillarId, 
      String? pillarName,}){
    _id = id;
    _type = type;
    _sectionId = sectionId;
    _sectionName = sectionName;
    _webPublicationDate = webPublicationDate;
    _webTitle = webTitle;
    _webUrl = webUrl;
    _apiUrl = apiUrl;
    _fields = fields;
    _isHosted = isHosted;
    _pillarId = pillarId;
    _pillarName = pillarName;
}

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _sectionId = json['sectionId'];
    _sectionName = json['sectionName'];
    _webPublicationDate = json['webPublicationDate'];
    _webTitle = json['webTitle'];
    _webUrl = json['webUrl'];
    _apiUrl = json['apiUrl'];
    _fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    _isHosted = json['isHosted'];
    _pillarId = json['pillarId'];
    _pillarName = json['pillarName'];
  }
  String? _id;
  String? _type;
  String? _sectionId;
  String? _sectionName;
  String? _webPublicationDate;
  String? _webTitle;
  String? _webUrl;
  String? _apiUrl;
  Fields? _fields;
  bool? _isHosted;
  String? _pillarId;
  String? _pillarName;

  String? get id => _id;
  String? get type => _type;
  String? get sectionId => _sectionId;
  String? get sectionName => _sectionName;
  String? get webPublicationDate => _webPublicationDate;
  String? get webTitle => _webTitle;
  String? get webUrl => _webUrl;
  String? get apiUrl => _apiUrl;
  Fields? get fields => _fields;
  bool? get isHosted => _isHosted;
  String? get pillarId => _pillarId;
  String? get pillarName => _pillarName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['sectionId'] = _sectionId;
    map['sectionName'] = _sectionName;
    map['webPublicationDate'] = _webPublicationDate;
    map['webTitle'] = _webTitle;
    map['webUrl'] = _webUrl;
    map['apiUrl'] = _apiUrl;
    if (_fields != null) {
      map['fields'] = _fields?.toJson();
    }
    map['isHosted'] = _isHosted;
    map['pillarId'] = _pillarId;
    map['pillarName'] = _pillarName;
    return map;
  }

}

class Fields {
  Fields({
      String? publication, 
      String? thumbnail,}){
    _publication = publication;
    _thumbnail = thumbnail;
}

  Fields.fromJson(dynamic json) {
    _publication = json['publication'];
    _thumbnail = json['thumbnail'];
  }
  String? _publication;
  String? _thumbnail;

  String? get publication => _publication;
  String? get thumbnail => _thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publication'] = _publication;
    map['thumbnail'] = _thumbnail;
    return map;
  }

}