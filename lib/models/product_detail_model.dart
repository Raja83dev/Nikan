class ProductDetail {
  String? id;
  String? inCart;
  String? title;
  String? save;
  int? commentCount;
  String? avrage;
  String? price;
  String? delPrice;
  String? image;
  String? des;
  int? stock;
  String? attribute;
  String? category;
  String? subCategory;
  String? childCategory;
  List<Gallery>? gallery;
  List<Size>? size;
  List<Comment>? comment;
  List<Details>? details;
  List<Related>? related;

  ProductDetail(
      {this.id,
      this.title,
      this.commentCount,
      this.avrage,
      this.price,
      this.delPrice,
      this.image,
      this.des,
      this.stock,
      this.attribute,
      this.category,
      this.subCategory,
      this.childCategory,
      this.gallery,
      this.size,
      this.comment,
      this.details,
      this.related,
      this.inCart,
      this.save});

  ProductDetail.fromJson(dynamic json) {
    save = json['save'].toString();
    id = json['product_id'].toString();
    inCart = json['cart'].toString();
    title = json['title'];
    commentCount = json['comment_count'];
    avrage = json['avrage'];
    price = json['price'];
    delPrice = json['del_price'].toString();
    image = json['image'];
    des = json['des'];
    stock = json['stock'];
    attribute = json['attribute'];
    category = json['category'];
    subCategory = json['sub_category'];
    childCategory = json['child_category'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(new Size.fromJson(v));
      });
    }
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    if (json['related'] != null) {
      related = <Related>[];
      json['related'].forEach((v) {
        related!.add(new Related.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['comment_count'] = this.commentCount;
    data['avrage'] = this.avrage;
    data['price'] = this.price;
    data['del_price'] = this.delPrice;
    data['image'] = this.image;
    data['des'] = this.des;
    data['stock'] = this.stock;
    data['attribute'] = this.attribute;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['child_category'] = this.childCategory;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.size != null) {
      data['size'] = this.size!.map((v) => v.toJson()).toList();
    }
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    if (this.related != null) {
      data['related'] = this.related!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallery {
  String? imgUrl;

  Gallery({this.imgUrl});

  Gallery.fromJson(Map<String, dynamic> json) {
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_url'] = this.imgUrl;
    return data;
  }
}

class Size {
  String? value;

  Size({this.value});

  Size.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class Comment {
  String? subjectCm;
  String? textCm;
  String? answer;
  String? user;
  String? createdAt;

  Comment(
      {this.subjectCm, this.textCm, this.answer, this.user, this.createdAt});

  Comment.fromJson(Map<String, dynamic> json) {
    subjectCm = json['subject_cm'];
    textCm = json['text_cm'];
    answer = json['answer'].toString();
    user = json['user'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_cm'] = this.subjectCm;
    data['text_cm'] = this.textCm;
    data['answer'] = this.answer;
    data['user'] = this.user;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Details {
  String? title;
  String? value;

  Details({this.title, this.value});

  Details.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}

class Related {
  int? id;
  String? title;
  String? image;
  String? price;
  String? delPrice;

  Related({this.id, this.title, this.image, this.price, this.delPrice});

  Related.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    delPrice = json['del_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    data['del_price'] = this.delPrice;
    return data;
  }
}
