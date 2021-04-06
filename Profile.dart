class Profile {
  String name;
  String cpf;
  DateTime birthday;
  String sex;

  Profile(String name, String cpf, DateTime birthday, String sex) {
    this.checkName(name);
    this.checkCpf(cpf);
    this.checkBirthday(birthday);
    this.checkSex(sex);
  }

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
    List sexList = ["Male", "Female"];

    if (sexList.contains(sex)) {
      this.sex = sex;
    } else {
      throw new FormatException("Error: sex doesn't exists.");
    }
  }

  void printProfile() {
    print("Name: " + this.name);
    print("CPF: " + this.cpf);
    print("Sex: " + this.sex);
    print("Age: " +
        (DateTime.now().difference(this.birthday).inDays / 365)
            .toStringAsPrecision(2));
  }
}
