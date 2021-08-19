class Goods {
  int code;
  String msg;
  List<Data> data;

  Goods({this.code, this.msg, this.data});

  Goods.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int createdOn;
  int modifiedOn;
  int fkUserGoods;
  int price;
  String keyword;
  String content;
  String image;
  String location;
  String address;
  int status;
  String nikeName;

  Data(
      {this.id,
      this.createdOn,
      this.modifiedOn,
      this.fkUserGoods,
      this.price,
      this.keyword,
      this.content,
      this.image,
      this.location,
      this.address,
      this.status,
      this.nikeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    fkUserGoods = json['fk_user_goods'];
    price = json['price'];
    keyword = json['keyword'];
    content = json['content'];
    image = json['image'];
    location = json['location'];
    address = json['address'];
    status = json['status'];
    nikeName = json['nike_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_on'] = this.createdOn;
    data['modified_on'] = this.modifiedOn;
    data['fk_user_goods'] = this.fkUserGoods;
    data['price'] = this.price;
    data['keyword'] = this.keyword;
    data['content'] = this.content;
    data['image'] = this.image;
    data['location'] = this.location;
    data['address'] = this.address;
    data['status'] = this.status;
    data['nike_name'] = this.nikeName;
    return data;
  }
}
