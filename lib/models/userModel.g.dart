import 'package:bcccoin/models/userModel.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
        id: reader.read(),
        name: reader.read(),
        email: reader.read(),
        phonenumber: reader.read(),
        dateOfBirth: reader.read(),
        gender: reader.read(),
        number: reader.read(),
        avenue: reader.read(),
        quartier: reader.read(),
        commune: reader.read(),
        password: reader.read(),
        bankName: reader.read());
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.email);
    writer.write(obj.phonenumber);
    writer.write(obj.dateOfBirth);
    writer.write(obj.gender);
    writer.write(obj.number);
    writer.write(obj.avenue);
    writer.write(obj.quartier);
    writer.write(obj.commune);
    writer.write(obj.password);
    writer.write(obj.bankName);
  }
}
