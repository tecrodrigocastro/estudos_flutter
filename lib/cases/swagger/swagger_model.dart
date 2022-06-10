class info {
  String? title;
  String? description;
  String? termsOfService;
  Contact? contact;
  License? license;
  String? version;

  info(
      {this.title,
      this.description,
      this.termsOfService,
      this.contact,
      this.license,
      this.version});

  info.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    termsOfService = json['termsOfService'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    license =
        json['license'] != null ? new License.fromJson(json['license']) : null;
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['termsOfService'] = this.termsOfService;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.license != null) {
      data['license'] = this.license!.toJson();
    }
    data['version'] = this.version;
    return data;
  }
}

class Contact {
  String? name;
  String? url;
  String? email;

  Contact({this.name, this.url, this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['email'] = this.email;
    return data;
  }
}

class License {
  String? name;
  String? url;

  License({this.name, this.url});

  License.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
