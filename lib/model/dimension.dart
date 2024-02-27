class DimensionDto {
  int? _id;
  String? _dimensionUnit;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['dimensionUnit'] = _dimensionUnit;
    return data;
  }

  DimensionDto.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _dimensionUnit = json['dimensionUnit'] ?? '';
  }

  DimensionDto(this._id, this._dimensionUnit);

  String? get dimensionUnit => _dimensionUnit;

  set dimensionUnit(String? value) {
    _dimensionUnit = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Dimension{_id: $_id, _dimensionUnit: $_dimensionUnit}';
  }
}