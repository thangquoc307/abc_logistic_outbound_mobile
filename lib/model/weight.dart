class Weight {
  int? _id;
  String? _weightUnit;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['weightUnit'] = _weightUnit;
    return data;
  }

  Weight.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _weightUnit = json['weightUnit'] ?? '';
  }

  Weight(this._id, this._weightUnit);

  String? get weightUnit => _weightUnit;

  set weightUnit(String? value) {
    _weightUnit = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Weight{_id: $_id, _weightUnit: $_weightUnit}';
  }
}