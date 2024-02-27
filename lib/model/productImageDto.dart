import 'fileDto.dart';

class ProductImageDto {
  int? id;
  String? link;
  String? text;
  FileDTO? productImage;

  ProductImageDto({
    this.id,
    this.link,
    this.text,
    this.productImage,
  });

  factory ProductImageDto.fromJson(Map<String, dynamic> json) => ProductImageDto(
    id: json['id'],
    link: json['link'],
    text: json['text'],
    productImage: json['productImage'] != null ? FileDTO.fromJson(json['productImage']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'link': link,
    'text': text,
    'productImage': productImage?.toJson(),
  };
}