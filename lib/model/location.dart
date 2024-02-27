class Location {
  int? _id;
  String? _locationNo;

  Location({int? id, String? locationNo}) {
    if (id != null) {
      this._id = id;
    }
    if (locationNo != null) {
      this._locationNo = locationNo;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get locationNo => _locationNo;
  set locationNo(String? locationNo) => _locationNo = locationNo;

  Location.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _locationNo = json['locationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['locationNo'] = this._locationNo;
    return data;
  }

  @override
  String toString() {
    return 'Location{_id: $_id, _locationNo: $_locationNo}';
  }
}