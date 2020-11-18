class Bean {
    String commit_from;
    String created_at;
    String creator;
    int creator_uid;
    String from;
    String from_who;
    String hitokoto;
    int id;
    int length;
    int reviewer;
    String type;
    String uuid;

    Bean({this.commit_from, this.created_at, this.creator, this.creator_uid, this.from, this.from_who, this.hitokoto, this.id, this.length, this.reviewer, this.type, this.uuid});

    factory Bean.fromJson(Map<String, dynamic> json) {
        return Bean(
            commit_from: json['commit_from'], 
            created_at: json['created_at'], 
            creator: json['creator'], 
            creator_uid: json['creator_uid'], 
            from: json['from'], 
            from_who: json['from_who'], 
            hitokoto: json['hitokoto'], 
            id: json['id'], 
            length: json['length'], 
            reviewer: json['reviewer'], 
            type: json['type'], 
            uuid: json['uuid'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['commit_from'] = this.commit_from;
        data['created_at'] = this.created_at;
        data['creator'] = this.creator;
        data['creator_uid'] = this.creator_uid;
        data['from'] = this.from;
        data['from_who'] = this.from_who;
        data['hitokoto'] = this.hitokoto;
        data['id'] = this.id;
        data['length'] = this.length;
        data['reviewer'] = this.reviewer;
        data['type'] = this.type;
        data['uuid'] = this.uuid;
        return data;
    }
}