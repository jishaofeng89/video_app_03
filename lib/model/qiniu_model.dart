class QiniuToken {
  int status;
  String info;
  String token;

  QiniuToken({this.status, this.info, this.token});

  QiniuToken.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    info = json['info'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['info'] = this.info;
    data['token'] = this.token;
    return data;
  }
}