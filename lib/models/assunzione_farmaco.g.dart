// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assunzione_farmaco.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssunzioneFarmacoAdapter extends TypeAdapter<AssunzioneFarmaco> {
  @override
  final int typeId = 0;

  @override
  AssunzioneFarmaco read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssunzioneFarmaco(
      id: fields[0] as int?,
      idFarmaco: fields[1] as int?,
      dosaggio: fields[2] as String?,
      orarioAssunzione: fields[3] as TimeOfDay?,
      viaDiSomministrazione: fields[4] as String?,
      noteAggiuntive: fields[5] as String?,
      nomeFarmaco: fields[6] as String?,
    )..letta = fields[7] as bool?;
  }

  @override
  void write(BinaryWriter writer, AssunzioneFarmaco obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idFarmaco)
      ..writeByte(2)
      ..write(obj.dosaggio)
      ..writeByte(3)
      ..write(obj.orarioAssunzione)
      ..writeByte(4)
      ..write(obj.viaDiSomministrazione)
      ..writeByte(5)
      ..write(obj.noteAggiuntive)
      ..writeByte(6)
      ..write(obj.nomeFarmaco)
      ..writeByte(7)
      ..write(obj.letta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssunzioneFarmacoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
