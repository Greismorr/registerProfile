import 'profile.dart';
import 'dart:io';

void main() async {
  print("\nEnter your name:");
  String currentProfileName = stdin.readLineSync();

  print("\nEnter your CPF (without dots):");
  String currentProfileCpf = stdin.readLineSync();

  print("\nEnter your Birthday (Year - Month - Day):");
  DateTime currentProfileBirthday = DateTime.parse(stdin.readLineSync());

  print("\nEnter your Sex (Male or Female):");
  String currentProfileSex = stdin.readLineSync();

  print("\nEnter your Message (or just press enter):");
  String currentMessage = stdin.readLineSync();

  Profile currentProfile = new Profile(currentProfileName, currentProfileCpf,
      currentProfileBirthday, currentProfileSex,
      message: currentMessage);

  //The printProfile is called after dirContents, yet dirContents input appears after. That's how async works.
  currentProfile.dirContents();
  currentProfile.printProfile();
  print(await currentProfile.saveProfile());

  print("\n\nEnter name of the Profile to be read:");
  currentProfile.printProfileAsJson(name: stdin.readLineSync());
}
