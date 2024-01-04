// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skull_king_database.dart';

// ignore_for_file: type=lint
class Games extends Table with TableInfo<Games, Game> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Games(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumnWithTypeConverter<Instant?, int> date =
      GeneratedColumn<int>('date', aliasedName, true,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              $customConstraints: 'UNIQUE')
          .withConverter<Instant?>(Games.$converterdaten);
  @override
  List<GeneratedColumn> get $columns => [id, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'games';
  @override
  VerificationContext validateIntegrity(Insertable<Game> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_dateMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Game map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Game(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: Games.$converterdaten.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])),
    );
  }

  @override
  Games createAlias(String alias) {
    return Games(attachedDatabase, alias);
  }

  static TypeConverter<Instant, int> $converterdate = const InstantConverter();
  static TypeConverter<Instant?, int?> $converterdaten =
      NullAwareTypeConverter.wrap($converterdate);
  @override
  bool get dontWriteConstraints => true;
}

class Game extends DataClass implements Insertable<Game> {
  final int id;
  final Instant? date;
  const Game({required this.id, this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<int>(Games.$converterdaten.toSql(date));
    }
    return map;
  }

  GamesCompanion toCompanion(bool nullToAbsent) {
    return GamesCompanion(
      id: Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Game.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Game(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<Instant?>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<Instant?>(date),
    };
  }

  Game copyWith({int? id, Value<Instant?> date = const Value.absent()}) => Game(
        id: id ?? this.id,
        date: date.present ? date.value : this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Game(')
          ..write('id: $id, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Game && other.id == this.id && other.date == this.date);
}

class GamesCompanion extends UpdateCompanion<Game> {
  final Value<int> id;
  final Value<Instant?> date;
  const GamesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
  });
  GamesCompanion.insert({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
  });
  static Insertable<Game> custom({
    Expression<int>? id,
    Expression<int>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
    });
  }

  GamesCompanion copyWith({Value<int>? id, Value<Instant?>? date}) {
    return GamesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(Games.$converterdaten.toSql(date.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class Players extends Table with TableInfo<Players, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Players(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _highScoreMeta =
      const VerificationMeta('highScore');
  late final GeneratedColumn<int> highScore = GeneratedColumn<int>(
      'high_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns => [id, name, highScore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(Insertable<Player> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('high_score')) {
      context.handle(_highScoreMeta,
          highScore.isAcceptableOrUnknown(data['high_score']!, _highScoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      highScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}high_score'])!,
    );
  }

  @override
  Players createAlias(String alias) {
    return Players(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final int highScore;
  const Player({required this.id, required this.name, required this.highScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['high_score'] = Variable<int>(highScore);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      highScore: Value(highScore),
    );
  }

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      highScore: serializer.fromJson<int>(json['high_score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'high_score': serializer.toJson<int>(highScore),
    };
  }

  Player copyWith({int? id, String? name, int? highScore}) => Player(
        id: id ?? this.id,
        name: name ?? this.name,
        highScore: highScore ?? this.highScore,
      );
  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('highScore: $highScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, highScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.highScore == this.highScore);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> highScore;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.highScore = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.highScore = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? highScore,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (highScore != null) 'high_score': highScore,
    });
  }

  PlayersCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? highScore}) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      highScore: highScore ?? this.highScore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (highScore.present) {
      map['high_score'] = Variable<int>(highScore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('highScore: $highScore')
          ..write(')'))
        .toString();
  }
}

class GameParticipants extends Table
    with TableInfo<GameParticipants, GameParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  GameParticipants(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _gameMeta = const VerificationMeta('game');
  late final GeneratedColumn<int> game = GeneratedColumn<int>(
      'game', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _playerMeta = const VerificationMeta('player');
  late final GeneratedColumn<int> player = GeneratedColumn<int>(
      'player', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, game, player];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_participants';
  @override
  VerificationContext validateIntegrity(Insertable<GameParticipant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('game')) {
      context.handle(
          _gameMeta, game.isAcceptableOrUnknown(data['game']!, _gameMeta));
    } else if (isInserting) {
      context.missing(_gameMeta);
    }
    if (data.containsKey('player')) {
      context.handle(_playerMeta,
          player.isAcceptableOrUnknown(data['player']!, _playerMeta));
    } else if (isInserting) {
      context.missing(_playerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {game, player},
      ];
  @override
  GameParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameParticipant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      game: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}game'])!,
      player: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player'])!,
    );
  }

  @override
  GameParticipants createAlias(String alias) {
    return GameParticipants(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'UNIQUE(game, player)',
        'FOREIGN KEY(game)REFERENCES games(id)ON UPDATE CASCADE ON DELETE CASCADE',
        'FOREIGN KEY(player)REFERENCES players(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class GameParticipant extends DataClass implements Insertable<GameParticipant> {
  final int id;
  final int game;
  final int player;
  const GameParticipant(
      {required this.id, required this.game, required this.player});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['game'] = Variable<int>(game);
    map['player'] = Variable<int>(player);
    return map;
  }

  GameParticipantsCompanion toCompanion(bool nullToAbsent) {
    return GameParticipantsCompanion(
      id: Value(id),
      game: Value(game),
      player: Value(player),
    );
  }

  factory GameParticipant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameParticipant(
      id: serializer.fromJson<int>(json['id']),
      game: serializer.fromJson<int>(json['game']),
      player: serializer.fromJson<int>(json['player']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'game': serializer.toJson<int>(game),
      'player': serializer.toJson<int>(player),
    };
  }

  GameParticipant copyWith({int? id, int? game, int? player}) =>
      GameParticipant(
        id: id ?? this.id,
        game: game ?? this.game,
        player: player ?? this.player,
      );
  @override
  String toString() {
    return (StringBuffer('GameParticipant(')
          ..write('id: $id, ')
          ..write('game: $game, ')
          ..write('player: $player')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, game, player);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameParticipant &&
          other.id == this.id &&
          other.game == this.game &&
          other.player == this.player);
}

class GameParticipantsCompanion extends UpdateCompanion<GameParticipant> {
  final Value<int> id;
  final Value<int> game;
  final Value<int> player;
  const GameParticipantsCompanion({
    this.id = const Value.absent(),
    this.game = const Value.absent(),
    this.player = const Value.absent(),
  });
  GameParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required int game,
    required int player,
  })  : game = Value(game),
        player = Value(player);
  static Insertable<GameParticipant> custom({
    Expression<int>? id,
    Expression<int>? game,
    Expression<int>? player,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (game != null) 'game': game,
      if (player != null) 'player': player,
    });
  }

  GameParticipantsCompanion copyWith(
      {Value<int>? id, Value<int>? game, Value<int>? player}) {
    return GameParticipantsCompanion(
      id: id ?? this.id,
      game: game ?? this.game,
      player: player ?? this.player,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (game.present) {
      map['game'] = Variable<int>(game.value);
    }
    if (player.present) {
      map['player'] = Variable<int>(player.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('game: $game, ')
          ..write('player: $player')
          ..write(')'))
        .toString();
  }
}

class GameDetail extends Table with TableInfo<GameDetail, GameDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  GameDetail(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _participantMeta =
      const VerificationMeta('participant');
  late final GeneratedColumn<int> participant = GeneratedColumn<int>(
      'participant', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _roundMeta = const VerificationMeta('round');
  late final GeneratedColumn<int> round = GeneratedColumn<int>(
      'round', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _predictedWinsMeta =
      const VerificationMeta('predictedWins');
  late final GeneratedColumn<int> predictedWins = GeneratedColumn<int>(
      'predicted_wins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _actualWinsMeta =
      const VerificationMeta('actualWins');
  late final GeneratedColumn<int> actualWins = GeneratedColumn<int>(
      'actual_wins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _bonusMeta = const VerificationMeta('bonus');
  late final GeneratedColumn<int> bonus = GeneratedColumn<int>(
      'bonus', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _roundPointsMeta =
      const VerificationMeta('roundPoints');
  late final GeneratedColumn<int> roundPoints = GeneratedColumn<int>(
      'round_points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _accumulatedPointsMeta =
      const VerificationMeta('accumulatedPoints');
  late final GeneratedColumn<int> accumulatedPoints = GeneratedColumn<int>(
      'accumulated_points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        participant,
        round,
        predictedWins,
        actualWins,
        bonus,
        roundPoints,
        accumulatedPoints
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_detail';
  @override
  VerificationContext validateIntegrity(Insertable<GameDetailData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('participant')) {
      context.handle(
          _participantMeta,
          participant.isAcceptableOrUnknown(
              data['participant']!, _participantMeta));
    } else if (isInserting) {
      context.missing(_participantMeta);
    }
    if (data.containsKey('round')) {
      context.handle(
          _roundMeta, round.isAcceptableOrUnknown(data['round']!, _roundMeta));
    } else if (isInserting) {
      context.missing(_roundMeta);
    }
    if (data.containsKey('predicted_wins')) {
      context.handle(
          _predictedWinsMeta,
          predictedWins.isAcceptableOrUnknown(
              data['predicted_wins']!, _predictedWinsMeta));
    } else if (isInserting) {
      context.missing(_predictedWinsMeta);
    }
    if (data.containsKey('actual_wins')) {
      context.handle(
          _actualWinsMeta,
          actualWins.isAcceptableOrUnknown(
              data['actual_wins']!, _actualWinsMeta));
    } else if (isInserting) {
      context.missing(_actualWinsMeta);
    }
    if (data.containsKey('bonus')) {
      context.handle(
          _bonusMeta, bonus.isAcceptableOrUnknown(data['bonus']!, _bonusMeta));
    } else if (isInserting) {
      context.missing(_bonusMeta);
    }
    if (data.containsKey('round_points')) {
      context.handle(
          _roundPointsMeta,
          roundPoints.isAcceptableOrUnknown(
              data['round_points']!, _roundPointsMeta));
    } else if (isInserting) {
      context.missing(_roundPointsMeta);
    }
    if (data.containsKey('accumulated_points')) {
      context.handle(
          _accumulatedPointsMeta,
          accumulatedPoints.isAcceptableOrUnknown(
              data['accumulated_points']!, _accumulatedPointsMeta));
    } else if (isInserting) {
      context.missing(_accumulatedPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameDetailData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      participant: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}participant'])!,
      round: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}round'])!,
      predictedWins: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}predicted_wins'])!,
      actualWins: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_wins'])!,
      bonus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bonus'])!,
      roundPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}round_points'])!,
      accumulatedPoints: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}accumulated_points'])!,
    );
  }

  @override
  GameDetail createAlias(String alias) {
    return GameDetail(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(participant)REFERENCES game_participants(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class GameDetailData extends DataClass implements Insertable<GameDetailData> {
  final int id;
  final int participant;
  final int round;
  final int predictedWins;
  final int actualWins;
  final int bonus;
  final int roundPoints;
  final int accumulatedPoints;
  const GameDetailData(
      {required this.id,
      required this.participant,
      required this.round,
      required this.predictedWins,
      required this.actualWins,
      required this.bonus,
      required this.roundPoints,
      required this.accumulatedPoints});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['participant'] = Variable<int>(participant);
    map['round'] = Variable<int>(round);
    map['predicted_wins'] = Variable<int>(predictedWins);
    map['actual_wins'] = Variable<int>(actualWins);
    map['bonus'] = Variable<int>(bonus);
    map['round_points'] = Variable<int>(roundPoints);
    map['accumulated_points'] = Variable<int>(accumulatedPoints);
    return map;
  }

  GameDetailCompanion toCompanion(bool nullToAbsent) {
    return GameDetailCompanion(
      id: Value(id),
      participant: Value(participant),
      round: Value(round),
      predictedWins: Value(predictedWins),
      actualWins: Value(actualWins),
      bonus: Value(bonus),
      roundPoints: Value(roundPoints),
      accumulatedPoints: Value(accumulatedPoints),
    );
  }

  factory GameDetailData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameDetailData(
      id: serializer.fromJson<int>(json['id']),
      participant: serializer.fromJson<int>(json['participant']),
      round: serializer.fromJson<int>(json['round']),
      predictedWins: serializer.fromJson<int>(json['predicted_wins']),
      actualWins: serializer.fromJson<int>(json['actual_wins']),
      bonus: serializer.fromJson<int>(json['bonus']),
      roundPoints: serializer.fromJson<int>(json['round_points']),
      accumulatedPoints: serializer.fromJson<int>(json['accumulated_points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'participant': serializer.toJson<int>(participant),
      'round': serializer.toJson<int>(round),
      'predicted_wins': serializer.toJson<int>(predictedWins),
      'actual_wins': serializer.toJson<int>(actualWins),
      'bonus': serializer.toJson<int>(bonus),
      'round_points': serializer.toJson<int>(roundPoints),
      'accumulated_points': serializer.toJson<int>(accumulatedPoints),
    };
  }

  GameDetailData copyWith(
          {int? id,
          int? participant,
          int? round,
          int? predictedWins,
          int? actualWins,
          int? bonus,
          int? roundPoints,
          int? accumulatedPoints}) =>
      GameDetailData(
        id: id ?? this.id,
        participant: participant ?? this.participant,
        round: round ?? this.round,
        predictedWins: predictedWins ?? this.predictedWins,
        actualWins: actualWins ?? this.actualWins,
        bonus: bonus ?? this.bonus,
        roundPoints: roundPoints ?? this.roundPoints,
        accumulatedPoints: accumulatedPoints ?? this.accumulatedPoints,
      );
  @override
  String toString() {
    return (StringBuffer('GameDetailData(')
          ..write('id: $id, ')
          ..write('participant: $participant, ')
          ..write('round: $round, ')
          ..write('predictedWins: $predictedWins, ')
          ..write('actualWins: $actualWins, ')
          ..write('bonus: $bonus, ')
          ..write('roundPoints: $roundPoints, ')
          ..write('accumulatedPoints: $accumulatedPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, participant, round, predictedWins,
      actualWins, bonus, roundPoints, accumulatedPoints);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameDetailData &&
          other.id == this.id &&
          other.participant == this.participant &&
          other.round == this.round &&
          other.predictedWins == this.predictedWins &&
          other.actualWins == this.actualWins &&
          other.bonus == this.bonus &&
          other.roundPoints == this.roundPoints &&
          other.accumulatedPoints == this.accumulatedPoints);
}

class GameDetailCompanion extends UpdateCompanion<GameDetailData> {
  final Value<int> id;
  final Value<int> participant;
  final Value<int> round;
  final Value<int> predictedWins;
  final Value<int> actualWins;
  final Value<int> bonus;
  final Value<int> roundPoints;
  final Value<int> accumulatedPoints;
  const GameDetailCompanion({
    this.id = const Value.absent(),
    this.participant = const Value.absent(),
    this.round = const Value.absent(),
    this.predictedWins = const Value.absent(),
    this.actualWins = const Value.absent(),
    this.bonus = const Value.absent(),
    this.roundPoints = const Value.absent(),
    this.accumulatedPoints = const Value.absent(),
  });
  GameDetailCompanion.insert({
    this.id = const Value.absent(),
    required int participant,
    required int round,
    required int predictedWins,
    required int actualWins,
    required int bonus,
    required int roundPoints,
    required int accumulatedPoints,
  })  : participant = Value(participant),
        round = Value(round),
        predictedWins = Value(predictedWins),
        actualWins = Value(actualWins),
        bonus = Value(bonus),
        roundPoints = Value(roundPoints),
        accumulatedPoints = Value(accumulatedPoints);
  static Insertable<GameDetailData> custom({
    Expression<int>? id,
    Expression<int>? participant,
    Expression<int>? round,
    Expression<int>? predictedWins,
    Expression<int>? actualWins,
    Expression<int>? bonus,
    Expression<int>? roundPoints,
    Expression<int>? accumulatedPoints,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (participant != null) 'participant': participant,
      if (round != null) 'round': round,
      if (predictedWins != null) 'predicted_wins': predictedWins,
      if (actualWins != null) 'actual_wins': actualWins,
      if (bonus != null) 'bonus': bonus,
      if (roundPoints != null) 'round_points': roundPoints,
      if (accumulatedPoints != null) 'accumulated_points': accumulatedPoints,
    });
  }

  GameDetailCompanion copyWith(
      {Value<int>? id,
      Value<int>? participant,
      Value<int>? round,
      Value<int>? predictedWins,
      Value<int>? actualWins,
      Value<int>? bonus,
      Value<int>? roundPoints,
      Value<int>? accumulatedPoints}) {
    return GameDetailCompanion(
      id: id ?? this.id,
      participant: participant ?? this.participant,
      round: round ?? this.round,
      predictedWins: predictedWins ?? this.predictedWins,
      actualWins: actualWins ?? this.actualWins,
      bonus: bonus ?? this.bonus,
      roundPoints: roundPoints ?? this.roundPoints,
      accumulatedPoints: accumulatedPoints ?? this.accumulatedPoints,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (participant.present) {
      map['participant'] = Variable<int>(participant.value);
    }
    if (round.present) {
      map['round'] = Variable<int>(round.value);
    }
    if (predictedWins.present) {
      map['predicted_wins'] = Variable<int>(predictedWins.value);
    }
    if (actualWins.present) {
      map['actual_wins'] = Variable<int>(actualWins.value);
    }
    if (bonus.present) {
      map['bonus'] = Variable<int>(bonus.value);
    }
    if (roundPoints.present) {
      map['round_points'] = Variable<int>(roundPoints.value);
    }
    if (accumulatedPoints.present) {
      map['accumulated_points'] = Variable<int>(accumulatedPoints.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameDetailCompanion(')
          ..write('id: $id, ')
          ..write('participant: $participant, ')
          ..write('round: $round, ')
          ..write('predictedWins: $predictedWins, ')
          ..write('actualWins: $actualWins, ')
          ..write('bonus: $bonus, ')
          ..write('roundPoints: $roundPoints, ')
          ..write('accumulatedPoints: $accumulatedPoints')
          ..write(')'))
        .toString();
  }
}

abstract class _$SkullKingDatabase extends GeneratedDatabase {
  _$SkullKingDatabase(QueryExecutor e) : super(e);
  late final Games games = Games(this);
  late final Players players = Players(this);
  late final GameParticipants gameParticipants = GameParticipants(this);
  late final GameDetail gameDetail = GameDetail(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [games, players, gameParticipants, gameDetail];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('games',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('game_participants', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('games',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('game_participants', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('players',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('game_participants', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('players',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('game_participants', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('game_participants',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('game_detail', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('game_participants',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('game_detail', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
