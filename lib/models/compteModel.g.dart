import 'package:bcccoin/models/compteModel.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class CompteModelAdapter extends TypeAdapter<CompteModel> {
  @override
  final int typeId = 2; // Assurez-vous que ce typeId correspond à celui défini dans CompteModel

  @override
  CompteModel read(BinaryReader reader) {
    return CompteModel(
      id: reader.read(),
      devise: reader.read(),
      name: reader.read(),
      solde: reader.read(),
       userModel: reader.read() as UserModel?, // Lecture du champ userModel
    );
  }

  @override
  void write(BinaryWriter writer, CompteModel obj) {
    writer.write(obj.id);
    writer.write(obj.devise);
    writer.write(obj.name);
    writer.write(obj.solde);
     writer.write(obj.userModel); // Écriture du champ userModel
  }
}
