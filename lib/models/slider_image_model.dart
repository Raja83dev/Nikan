// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SliderImageModel {

  String image;
  String url;
  
  SliderImageModel({
    required this.image,
    required this.url,
  });

  


  SliderImageModel copyWith({
    String? image,
    String? url,
  }) {
    return SliderImageModel(
      image: image ?? this.image,
      url: url ?? this.url,
    );
  }

 

}
