import 'Profile.dart';
import 'dart:io';

void main() {
  print("\nEnter your name:");
  String currentProfileName = stdin.readLineSync();

  print("\nEnter your CPF (without dots):");
  String currentProfileCpf = stdin.readLineSync();

  print("\nEnter your Birthday (Year - Month - Day):");
  DateTime currentProfileBirthday = DateTime.parse(stdin.readLineSync());

  print("\nEnter your Sex (Male or Female):");
  String currentProfileSex = stdin.readLineSync();

  Profile currentProfile = new Profile(currentProfileName, currentProfileCpf,
      currentProfileBirthday, currentProfileSex);

  currentProfile.printProfile();
}
