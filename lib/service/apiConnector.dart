import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_outbound/model/inventoryLocationProductDetail.dart';
import 'package:flutter_outbound/model/outboundProductDetailDto.dart';
import 'package:flutter_outbound/model/customer.dart';
import 'package:flutter_outbound/model/dimension.dart';
import 'package:flutter_outbound/model/outbound.dart';
import 'package:flutter_outbound/model/outboundPackedDto.dart';
import 'package:flutter_outbound/model/product.dart';
import 'package:flutter_outbound/model/relabelDetail.dart';
import 'package:flutter_outbound/model/shipping.dart';
import 'package:flutter_outbound/model/weight.dart';
import 'package:http/http.dart' as http;

class ApiConnector {
  static const String prefixUrlOutboundApi = "http://192.168.1.25:9380/api/1.0/outbound/";
  static const String prefixUrlOldOutboundApi = "http://192.168.1.25:9380/api/outbound/";
  static const String prefixUrlCustomerApi = "http://192.168.1.25:9280/api/";
  static const String prefixUrlPrinterApi = "http://192.168.1.25:8080/api/public/";
  static const String prefixUrlRelabelApi = "http://51.79.255.60:9580/api/relabel/";
  static const String zplConvertApi = "http://api.labelary.com/v1/printers/8dpmm/labels/4x6/0/";

  static Future<Map<String, dynamic>?> pageSearchOutbound(int page, String searchWord, int itemOfPage) async {
    String link = "${prefixUrlOutboundApi}list?"
        "page=${page}&numberOfPage=${itemOfPage}&searchWord=${searchWord}";
    print(link);
    final res = await http.get(Uri.parse(link));

    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody);
      final Map<String, dynamic> result = {"totalPages" : responseData["totalPages"]};

      if (responseData.containsKey("content") && responseData["content"] is List) {
        final List<dynamic> productList = responseData["content"];
          final List<Outbound> outboundList = productList
              .map((dynamic e) => Outbound.fromJson(e)).toList();
          result['data'] = outboundList;
      } else {
        result['data'] = [];
      }
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> pageSearchPickedOutbound(int page, String searchWord, int itemOfPage) async {
    String link = "${prefixUrlOutboundApi}list-outbound-picked-information?"
        "page=${page}&numberOfPage=${itemOfPage}&searchWord=${searchWord}";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody);
      final Map<String, dynamic> result = {"totalPages" : responseData["totalPages"]};

      if (responseData.containsKey("content") && responseData["content"] is List) {
        final List<dynamic> productList = responseData["content"];
        final List<OutboundProductDetailDto> outboundList = productList
            .map((dynamic e) => OutboundProductDetailDto.fromJson(e)).toList();
        result['data'] = outboundList;
      } else {
        result['data'] = [];
      }
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> pageSearchPackedOutbound(int page, String searchWord, int itemOfPage) async {
    String link = "${prefixUrlOutboundApi}list-outbound-packed-information?"
        "page=${page}&numberOfPage=${itemOfPage}&searchWord=${searchWord}";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody);
      final Map<String, dynamic> result = {"totalPages" : responseData["totalPages"]};

      if (responseData.containsKey("content") && responseData["content"] is List) {
        final List<dynamic> productList = responseData["content"];
        final List<OutboundPackedDto> outboundList = productList
            .map((dynamic e) => OutboundPackedDto.fromJson(e)).toList();
        result['data'] = outboundList;
      } else {
        result['data'] = [];
      }
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> pageSearchShipping(int page, String searchWord, int itemOfPage) async {
    String link = "${prefixUrlOutboundApi}shipped-information?"
        "page=${page}&numberOfPage=${itemOfPage}&searchWord=${searchWord}";
    print(link);
    final res = await http.get(Uri.parse(link));

    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody);
      final Map<String, dynamic> result = {"totalPages" : responseData["totalPages"]};

      if (responseData.containsKey("content") && responseData["content"] is List) {
        final List<dynamic> productList = responseData["content"];
        final List<Shipping> shippingList = productList
            .map((dynamic e) => Shipping.fromJson(e)).toList();
        result['data'] = shippingList;
      } else {
        result['data'] = [];
      }
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<List<Weight>?> getAllWeightUnit() async {
    String link = "${prefixUrlOutboundApi}weight";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final List<dynamic> productList = json.decode(res.body);
      final List<Weight> result = productList
          .map((dynamic e) => Weight.fromJson(e)).toList();
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<List<DimensionDto>?> getAllDimensionUnit() async {
    String link = "${prefixUrlOutboundApi}dimension";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final List<dynamic> productList = json.decode(res.body);
      final List<DimensionDto> result = productList
          .map((dynamic e) => DimensionDto.fromJson(e)).toList();
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<List<Product>?> getProductByCustomerId(int customerId) async {
    String link = "${prefixUrlCustomerApi}products/customer/${customerId}";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final List<dynamic> productList = json.decode(responseBody)['data']['products'];
      final List<Product> result = productList
          .map((dynamic e) => Product.fromJson(e))
          .toList();
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<List<Customer>?> getAllCustomer() async {
    String link = "${prefixUrlCustomerApi}customers";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final List<dynamic> customerList = json.decode(responseBody)['data']['customers'];
      final List<Customer> result = customerList
          .map((dynamic e) => Customer.fromJson(e)).toList();
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<Outbound?> createOutbound(Outbound outbound, bool isCreate) async {
    final String link = "$prefixUrlOldOutboundApi${isCreate ? 'create' : 'update'}";
    print(link);
    final Uri uri = Uri.parse(link);
    final res = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(outbound.toJson()),
      encoding: Encoding.getByName("utf-8")
    );
    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final dynamic responseData = json.decode(responseBody)['data']['outbound'];
      Outbound result = Outbound.fromJson(responseData);
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<double?> getQtyRemainingInInventory(int? productId, num qty) async {
    final String link = "${prefixUrlOldOutboundApi}get-qty-remaning-in-inventory?productId=${productId}&qty=${qty}";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      double result = data['data']['qtyRemainingInInventory'];
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }
  static Future<List<InventoryLocationProductDetail>?> getInventoryLocationProductDetail(int? productId) async {
    final String link = "${prefixUrlOldOutboundApi}get-total-qty-by-product/${productId}";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(res.body)['data']['inventoryLocationProductDetail'];
      final List<InventoryLocationProductDetail> result = jsonList
          .map((dynamic e) => InventoryLocationProductDetail.fromJson(e)).toList();
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }
  static Future<double?>? getConvertFactor (int productId) async {
    final String link = "${prefixUrlCustomerApi}product/${productId}";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final double factor = json.decode(res.body)['data']['product']['productPackaging']['size'];
      return factor;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }
  static Future<Outbound?> getOutboundById (int outboundId) async {
    final String link = "$prefixUrlOldOutboundApi$outboundId";
    print(link);
    final res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      final Outbound outbound =
      Outbound.fromJson(json.decode(res.body)['data']['outbound']);
      return outbound;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<Uint8List?> convertZplToImage (String zplCode) async {
    print(zplConvertApi);
    final Uri uri = Uri.parse(zplConvertApi);
    final res = await http.post(
        uri,
        headers: {
          'Accept': 'image/png',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: zplCode,
        encoding: Encoding.getByName("utf-8")
    );

    if (res.statusCode == 200) {
      return res.bodyBytes;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<bool?> printZpl(String zplCode) async {
    const String link = "${prefixUrlPrinterApi}print-zpl";
    print(link);
    final Uri uri = Uri.parse(link);
    final res = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "zplCode": zplCode
        }),
        encoding: Encoding.getByName("utf-8")
    );
    if (res.statusCode == 200) {

      return false;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> pageSearchRelabel(int page, String searchWord, int itemOfPage) async {
    String link = "${prefixUrlRelabelApi}get-all-relabel-detail?"
        "page=${page}&size=${itemOfPage}";
    print(link);
    final res = await http.get(Uri.parse(link));

    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody)['data']['relabelDetails'];
      final Map<String, dynamic> result = {"totalPages" : responseData["totalPages"]};

      if (responseData.containsKey("content") && responseData["content"] is List) {
        final List<dynamic> productList = responseData["content"];
        final List<RelabelDetail> relabelDetailList = productList
            .map((dynamic e) => RelabelDetail.fromJson(e)).toList();
        result['data'] = relabelDetailList;
      } else {
        result['data'] = [];
      }
      return result;
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  static Future<List<RelabelDetail>?> getRelabelByOriginBarcode(String originBarcode) async {
    String link = "${prefixUrlRelabelApi}get-relabel-by-original-barcode/${originBarcode}";
    print(link);
    final res = await http.get(Uri.parse(link));

    if (res.statusCode == 200) {
      final String responseBody = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody)['data'];

      if (responseData.containsKey("relabelDetail") && responseData["relabelDetail"] is List) {
        final List<dynamic> productList = responseData["relabelDetail"];
        final List<RelabelDetail> relabelDetailList = productList
            .map((dynamic e) => RelabelDetail.fromJson(e)).toList();
        return relabelDetailList;
      } else {
        return [];
      }
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }
}
