class CartProductModel {
  String? id;
  String? title;
  String? price;
  String? delPrice;
  String? image;

  CartProductModel(
      {this.id, this.title, this.price, this.delPrice, this.image});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    delPrice = json['del_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['del_price'] = this.delPrice;
    data['image'] = this.image;
    return data;
  }
}