class FileDTO {
  int? id;
  String? name;
  String? fileOnServer;
  String? relativePath;
  String? linkImage;

  FileDTO({
    this.id,
    this.name,
    this.fileOnServer,
    this.relativePath,
    this.linkImage,
  });

  factory FileDTO.fromJson(Map<String, dynamic> json) => FileDTO(
    id: json['id'],
    name: json['name'],
    fileOnServer: json['fileOnServer'],
    relativePath: json['relativePath'],
    linkImage: json['linkImage'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'fileOnServer': fileOnServer,
    'relativePath': relativePath,
    'linkImage': linkImage,
  };
}