part of 'password_entry.dart';

class PasswordEntryAdapter extends TypeAdapter<PasswordEntry> {
  @override
  final int typeId = 0;

  @override
  PasswordEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PasswordEntry(
      title: fields[0] as String,
      username: fields[1] as String,
      password: fields[2] as String,
      website: fields[3] as String,
      notes: fields[4] as String?,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PasswordEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.website)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}