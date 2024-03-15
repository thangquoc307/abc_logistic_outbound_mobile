import 'RelabelDetailFiles.dart';

class RelabelDetail {
  int? _id;
  num? _page;
  String? _originalBarcode;
  String? _newBarcode;
  DateTime? _createdDate;
  RelabelDetailFiles? _relabelDetailFiles;


  RelabelDetail(this._id, this._page, this._originalBarcode, this._newBarcode,
      this._createdDate, this._relabelDetailFiles);


  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  num? get page => _page;

  set page(num? value) {
    _page = value;
  }

  String? get originalBarcode => _originalBarcode;

  set originalBarcode(String? value) {
    _originalBarcode = value;
  }

  String? get newBarcode => _newBarcode;

  set newBarcode(String? value) {
    _newBarcode = value;
  }

  DateTime? get createdDate => _createdDate;

  set createdDate(DateTime? value) {
    _createdDate = value;
  }

  RelabelDetailFiles? get relabelDetailFiles => _relabelDetailFiles;

  set relabelDetailFiles(RelabelDetailFiles? value) {
    _relabelDetailFiles = value;
  }

  RelabelDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _page = json['page'];
    _originalBarcode = json['originalBarcode'];
    _newBarcode = json['newBarcode'];
    _createdDate = json['createdDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['createdDate'])
        : null;
    _relabelDetailFiles = json['relabelDetailFiles'] != null
        ? RelabelDetailFiles.fromJson(json['relabelDetailFiles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this._id;
    data['page'] = this._page;
    data['originalBarcode'] = this._originalBarcode;
    data['newBarcode'] = this._newBarcode;
    data['createdDate'] = this._createdDate != null ?
    this._createdDate!.millisecondsSinceEpoch : null;
    if (this._relabelDetailFiles != null) {
      data['relabelDetailFiles'] = this._relabelDetailFiles!.toJson();
    }
    return data;
  }
}