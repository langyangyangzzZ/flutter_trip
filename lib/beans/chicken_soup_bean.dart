/// id : 6503
/// uuid : "6c7697d2-46e1-413b-a40c-11a999bfd0db"
/// hitokoto : "我们把世界看错，反说它欺骗了我们。"
/// type : "k"
/// from : "飞鸟集"
/// from_who : "泰戈尔"
/// creator : "恏戋余"
/// creator_uid : 7045
/// reviewer : 6844
/// commit_from : "app"
/// created_at : "1598342433"
/// length : 17

class ChickenSoupBean {
  int _id;
  String _uuid;
  String _hitokoto;
  String _type;
  String _from;
  String _fromWho;
  String _creator;
  int _creatorUid;
  int _reviewer;
  String _commitFrom;
  String _createdAt;
  int _length;

  int get id => _id;
  String get uuid => _uuid;
  String get hitokoto => _hitokoto;
  String get type => _type;
  String get from => _from;
  String get fromWho => _fromWho;
  String get creator => _creator;
  int get creatorUid => _creatorUid;
  int get reviewer => _reviewer;
  String get commitFrom => _commitFrom;
  String get createdAt => _createdAt;
  int get length => _length;

  ChickenSoupBean({
      int id, 
      String uuid, 
      String hitokoto, 
      String type, 
      String from, 
      String fromWho, 
      String creator, 
      int creatorUid, 
      int reviewer, 
      String commitFrom, 
      String createdAt, 
      int length}){
    _id = id;
    _uuid = uuid;
    _hitokoto = hitokoto;
    _type = type;
    _from = from;
    _fromWho = fromWho;
    _creator = creator;
    _creatorUid = creatorUid;
    _reviewer = reviewer;
    _commitFrom = commitFrom;
    _createdAt = createdAt;
    _length = length;
}

  ChickenSoupBean.fromJson(dynamic json) {
    _id = json["id"];
    _uuid = json["uuid"];
    _hitokoto = json["hitokoto"];
    _type = json["type"];
    _from = json["from"];
    _fromWho = json["from_who"];
    _creator = json["creator"];
    _creatorUid = json["creator_uid"];
    _reviewer = json["reviewer"];
    _commitFrom = json["commit_from"];
    _createdAt = json["created_at"];
    _length = json["length"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["uuid"] = _uuid;
    map["hitokoto"] = _hitokoto;
    map["type"] = _type;
    map["from"] = _from;
    map["from_who"] = _fromWho;
    map["creator"] = _creator;
    map["creator_uid"] = _creatorUid;
    map["reviewer"] = _reviewer;
    map["commit_from"] = _commitFrom;
    map["created_at"] = _createdAt;
    map["length"] = _length;
    return map;
  }

}