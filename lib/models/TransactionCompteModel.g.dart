import 'package:bcccoin/models/TransactionCompteModel.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class TransactionCompteModelAdapter
    extends TypeAdapter<TransactionCompteModel> {
  @override
  final int typeId = 3;

  @override
  TransactionCompteModel read(BinaryReader reader) {
    return TransactionCompteModel(
      id: reader.read(),
      compteSourceId: reader.read(),
      compteDestinationId: reader.read(),
      montantTransaction: reader.read(),
      soldeSourceAvant: reader.read(),
      soldeDestinationAvant: reader.read(),
      soldeSource: reader.read(),
      soldeDestination: reader.read(),
      taux: reader.read(),
      date: reader.read(),
      idAgent: reader.read(),
      libele: reader.read(),
      service: reader.read(),
      proprietaire: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionCompteModel obj) {
    writer.write(obj.id);
    writer.write(obj.compteSourceId);
    writer.write(obj.compteDestinationId);
    writer.write(obj.montantTransaction);
    writer.write(obj.soldeSourceAvant);
    writer.write(obj.soldeDestinationAvant);
    writer.write(obj.soldeSource);
    writer.write(obj.soldeDestination);
    writer.write(obj.taux);
    writer.write(obj.date);
    writer.write(obj.idAgent);
    writer.write(obj.libele);
    writer.write(obj.service);
    writer.write(obj.proprietaire);
  }
}
