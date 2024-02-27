import 'customer.dart';
import 'inventory.dart';
import 'skus.dart';
import 'productPackaging.dart';
import 'productImageDto.dart';

class Product {
  int? id;
  String? productNo;
  Customer? customer;
  String? name;
  String? upc;
  DateTime? createdDate;
  DateTime? lastModifiedDate;
  List<Skus>? skus;
  bool? status;
  bool? stockStatus;
  String? color;
  String? description;
  String? note;
  ProductPackaging? productPackaging;
  List<ProductImageDto>? images;
  Inventory? inventory;


  Product(
      {this.id,
        this.productNo,
        this.customer,
        this.name,
        this.upc,
        this.createdDate,
        this.lastModifiedDate,
        this.skus,
        this.status,
        this.stockStatus,
        this.color,
        this.description,
        this.note,
        this.productPackaging,
        this.images,
        this.inventory});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productNo = json['productNo'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    name = json['name'];
    upc = json['upc'];
    createdDate = json['createdDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['createdDate'])
        : null;
    lastModifiedDate = json['lastModifiedDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['lastModifiedDate'])
        : null;
    if (json['skus'] != null) {
      skus = <Skus>[];
      json['skus'].forEach((v) {
        skus!.add(Skus.fromJson(v));
      });
    }
    status = json['status'];
    stockStatus = json['stockStatus'];
    color = json['color'];
    description = json['description'];
    note = json['note'];
    productPackaging = json['productPackaging'] != null
        ? ProductPackaging.fromJson(json['productPackaging'])
        : null;
    if (json['images'] != null) {
      images = <ProductImageDto>[];
      json['images'].forEach((v) {
        images!.add(ProductImageDto.fromJson(v));
      });
    }
    inventory = json['inventory'] != null
        ? Inventory.fromJson(json['inventory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productNo'] = productNo;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['name'] = name;
    data['upc'] = upc;
    data['createdDate'] = createdDate != null ?
    createdDate!.millisecondsSinceEpoch : null;
    data['lastModifiedDate'] = lastModifiedDate != null ?
    lastModifiedDate!.millisecondsSinceEpoch : null;
    if (skus != null) {
      data['skus'] = skus!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['stockStatus'] = stockStatus;
    data['color'] = color;
    data['description'] = description;
    data['note'] = note;
    if (productPackaging != null) {
      data['productPackaging'] = productPackaging!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (inventory != null) {
      data['inventory'] = inventory!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Product{id: $id, productNo: $productNo, customer: $customer, name: $name, upc: $upc, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate, skus: $skus, status: $status, stockStatus: $stockStatus, color: $color, description: $description, note: $note, productPackaging: $productPackaging, images: $images, inventory: $inventory}';
  }
}