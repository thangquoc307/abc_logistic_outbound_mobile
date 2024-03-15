import 'relabelDetailFile.dart';

class RelabelDetailFiles {
  int? _id;
  String? _link;
  String? _text;
  RelabelDetailFile? _relabelDetailFile;

  RelabelDetailFiles(
      {int? id,
        String? link,
        String? text,
        RelabelDetailFile? relabelDetailFile}) {
    if (id != null) {
      this._id = id;
    }
    if (link != null) {
      this._link = link;
    }
    if (text != null) {
      this._text = text;
    }
    if (relabelDetailFile != null) {
      this._relabelDetailFile = relabelDetailFile;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get link => _link;
  set link(String? link) => _link = link;
  String? get text => _text;
  set text(String? text) => _text = text;
  RelabelDetailFile? get relabelDetailFile => _relabelDetailFile;
  set relabelDetailFile(RelabelDetailFile? relabelDetailFile) =>
      _relabelDetailFile = relabelDetailFile;

  RelabelDetailFiles.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _link = json['link'];
    _text = json['text'];
    _relabelDetailFile = json['relabelDetailFile'] != null
        ? RelabelDetailFile.fromJson(json['relabelDetailFile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['link'] = _link;
    data['text'] = _text;
    if (_relabelDetailFile != null) {
      data['relabelDetailFile'] = _relabelDetailFile!.toJson();
    }
    return data;
  }
}