import 'package:drift/drift.dart' show TypeConverter;
import 'package:time_machine/time_machine.dart';

class InstantConverter extends TypeConverter<Instant, int> {
  const InstantConverter();
  @override
  Instant fromSql(int fromDb) {
    return Instant.fromEpochMilliseconds(fromDb);
  }

  @override
  int toSql(Instant value) {
    return value.epochMilliseconds;
  }
}


