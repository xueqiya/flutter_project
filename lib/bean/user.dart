class User {
  int code;
  String msg;
  Data data;

  User({this.code, this.msg, this.data});

  User.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int createdOn;
  int modifiedOn;
  String phone;
  String nikeName;
  int age;
  int status;

  Data(
      {this.id,
        this.createdOn,
        this.modifiedOn,
        this.phone,
        this.nikeName,
        this.age,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    phone = json['phone'];
    nikeName = json['nike_name'];
    age = json['age'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_on'] = this.createdOn;
    data['modified_on'] = this.modifiedOn;
    data['phone'] = this.phone;
    data['nike_name'] = this.nikeName;
    data['age'] = this.age;
    data['status'] = this.status;
    return data;
  }
}
