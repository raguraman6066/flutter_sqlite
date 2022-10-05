class User {
  int? id;
  String name = '';
  String mobile = '';
  String description = '';
  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name;
    mapping['mobile'] = mobile;
    mapping['description'] = description;
    return mapping;
  }
}
