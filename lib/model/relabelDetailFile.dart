class RelabelDetailFile {
  int? _id;
  String? _name;
  String? _fileOnServer;
  String? _relativePath;
  String? _linkImage;

  RelabelDetailFile(
      {int? id,
        String? name,
        String? fileOnServer,
        String? relativePath,
        String? linkImage}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (fileOnServer != null) {
      this._fileOnServer = fileOnServer;
    }
    if (relativePath != null) {
      this._relativePath = relativePath;
    }
    if (linkImage != null) {
      this._linkImage = linkImage;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get fileOnServer => _fileOnServer;
  set fileOnServer(String? fileOnServer) => _fileOnServer = fileOnServer;
  String? get relativePath => _relativePath;
  set relativePath(String? relativePath) => _relativePath = relativePath;
  String? get linkImage => _linkImage;
  set linkImage(String? linkImage) => _linkImage = linkImage;

  RelabelDetailFile.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _fileOnServer = json['fileOnServer'];
    _relativePath = json['relativePath'];
    _linkImage = json['linkImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['fileOnServer'] = this._fileOnServer;
    data['relativePath'] = this._relativePath;
    data['linkImage'] = this._linkImage;
    return data;
  }
}