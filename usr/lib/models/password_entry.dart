import 'package:hive/hive.dart';

part 'password_entry.g.dart';

@HiveType(typeId: 0)
class PasswordEntry extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  String website;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  DateTime createdAt;

  PasswordEntry({
    required this.title,
    required this.username,
    required this.password,
    required this.website,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  PasswordEntry copyWith({
    String? title,
    String? username,
    String? password,
    String? website,
    String? notes,
  }) {
    return PasswordEntry(
      title: title ?? this.title,
      username: username ?? this.username,
      password: password ?? this.password,
      website: website ?? this.website,
      notes: notes ?? this.notes,
      createdAt: this.createdAt,
    );
  }
}