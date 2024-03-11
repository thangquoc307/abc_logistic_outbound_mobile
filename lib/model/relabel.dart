class Relabel {
  int _id;
  String _originalBarcode;
  String _newBarcode;
  String _zplCode;

  Relabel(this._id, this._originalBarcode, this._newBarcode, this._zplCode);

  String get zplCode => _zplCode;

  set zplCode(String value) {
    _zplCode = value;
  }

  String get newBarcode => _newBarcode;

  set newBarcode(String value) {
    _newBarcode = value;
  }

  String get originalBarcode => _originalBarcode;

  set originalBarcode(String value) {
    _originalBarcode = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}