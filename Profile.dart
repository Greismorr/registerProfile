import 'dart:async';
import 'dart:convert';

import 'dart:io';

class Profile {
  String name;
  String cpf;
  DateTime birthday;
  String sex;
  String message;

  Profile(String name, String cpf, DateTime birthday, String sex,
      {String message}) {
    this.checkName(name);
    this.checkCpf(cpf);
    this.checkBirthday(birthday);
    this.checkSex(sex);
    this.message = message;
  }

  Profile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cpf = json['cpf'],
        sex = json['sex'],
        birthday = DateTime.parse(json['birthday']),
        message = json['message'];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'cpf': this.cpf,
        'sex': this.sex,
        'birthday': this.birthday.toString(),
        'message': this.message,
      };

  void checkName(String name) {
    if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      this.name = name;
    } else {
      throw new FormatException("Error: Name must have only letters.");
    }
  }

  void checkCpf(String cpf) {
    if (RegExp(r'^[0-9]+$').hasMatch(cpf) && (cpf.length == 11)) {
      this.cpf = cpf;
    } else {
      throw new FormatException("Error: CPF must have 11 digits.");
    }
  }

  void checkBirthday(DateTime birthday) {
    try {
      this.birthday = birthday;
    } on FormatException {
      throw new FormatException(
          "Error: your birthday must be on format Year - Month - Day.");
    }
  }

  void checkSex(String sex) {
    List sexList = ["male", "female"];

    if (sexList.contains(sex.toLowerCase())) {
      this.sex = sex;
    } else {
      throw new FormatException("Error: sex doesn't exists.");
    }
  }

  String calculateAge() {
    return (DateTime.now().difference(this.birthday).inDays / 365)
        .toStringAsPrecision(2);
  }

  void printProfile() {
    print("Name: ${this.name}");
    print("CPF: ${this.cpf}");
    print("Sex: ${this.sex}");
    print("Age: ${this.calculateAge()}");
    print("Message: ${this.message}");
  }

  void printProfileAsJson({String name}) async {
    var jsonString = await File('Profiles/${name}.txt').readAsString();

    Map<String, dynamic> profileMap = jsonDecode(jsonString);

    var selectedProfile = Profile.fromJson(profileMap);

    print("\n ${selectedProfile.name}");
    print("\n ${selectedProfile.sex}");
    print("\n ${selectedProfile.cpf}");
    print("\n ${selectedProfile.calculateAge()}");
    print("\n ${selectedProfile.message}");
  }

  Future<List<String>> dirContents() async {
    try {
      Directory dir = new Directory(Directory.current.path + "/Profiles");
      print(dir.toString());
      var files = <String>[];
      var completer = Completer<List<String>>();
      var lister = dir.list(recursive: false);

      lister.listen(
          (file) => files.add(
              file.path.substring(file.path.toString().lastIndexOf("\\") + 1)),
          onDone: () => completer.complete(files));
      completer.future.then((value) => print(value));
    } catch (error) {
      print(error);
    }
  }

  void saveProfile() {
    new File("Profiles/${this.name}.txt")
        .create(recursive: true)
        .then((File file) => file.writeAsString(jsonEncode(this.toJson())));
  }
}
