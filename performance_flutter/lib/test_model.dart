class TestModel {
  final String name;
  final String language;
  final String id;
  final String bio;
  final double version;

  TestModel(this.name, this.language, this.id, this.bio, this.version);

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(json['name'], json['language'], json['id'], json['bio'], json['version']);
  }
}
