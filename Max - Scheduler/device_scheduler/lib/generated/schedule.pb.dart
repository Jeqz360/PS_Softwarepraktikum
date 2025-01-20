//
//  Generated code. Do not modify.
//  source: schedule.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'schedule.pbenum.dart';

export 'schedule.pbenum.dart';

class Aggregate extends $pb.GeneratedMessage {
  factory Aggregate({
    Aggregate_Type? type,
    $core.Iterable<Condition>? conditions,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (conditions != null) {
      $result.conditions.addAll(conditions);
    }
    return $result;
  }
  Aggregate._() : super();
  factory Aggregate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Aggregate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Aggregate', createEmptyInstance: create)
    ..e<Aggregate_Type>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Aggregate_Type.AND, valueOf: Aggregate_Type.valueOf, enumValues: Aggregate_Type.values)
    ..pc<Condition>(2, _omitFieldNames ? '' : 'conditions', $pb.PbFieldType.PM, subBuilder: Condition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Aggregate clone() => Aggregate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Aggregate copyWith(void Function(Aggregate) updates) => super.copyWith((message) => updates(message as Aggregate)) as Aggregate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Aggregate create() => Aggregate._();
  Aggregate createEmptyInstance() => create();
  static $pb.PbList<Aggregate> createRepeated() => $pb.PbList<Aggregate>();
  @$core.pragma('dart2js:noInline')
  static Aggregate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Aggregate>(create);
  static Aggregate? _defaultInstance;

  @$pb.TagNumber(1)
  Aggregate_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Aggregate_Type v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Condition> get conditions => $_getList(1);
}

class Cron extends $pb.GeneratedMessage {
  factory Cron({
    $core.String? cron,
  }) {
    final $result = create();
    if (cron != null) {
      $result.cron = cron;
    }
    return $result;
  }
  Cron._() : super();
  factory Cron.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cron.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Cron', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cron')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cron clone() => Cron()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cron copyWith(void Function(Cron) updates) => super.copyWith((message) => updates(message as Cron)) as Cron;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Cron create() => Cron._();
  Cron createEmptyInstance() => create();
  static $pb.PbList<Cron> createRepeated() => $pb.PbList<Cron>();
  @$core.pragma('dart2js:noInline')
  static Cron getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Cron>(create);
  static Cron? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cron => $_getSZ(0);
  @$pb.TagNumber(1)
  set cron($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCron() => $_has(0);
  @$pb.TagNumber(1)
  void clearCron() => clearField(1);
}

class Time extends $pb.GeneratedMessage {
  factory Time({
    $core.String? start,
    $core.String? end,
  }) {
    final $result = create();
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    return $result;
  }
  Time._() : super();
  factory Time.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Time.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Time', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'start')
    ..aOS(2, _omitFieldNames ? '' : 'end')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Time clone() => Time()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Time copyWith(void Function(Time) updates) => super.copyWith((message) => updates(message as Time)) as Time;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Time create() => Time._();
  Time createEmptyInstance() => create();
  static $pb.PbList<Time> createRepeated() => $pb.PbList<Time>();
  @$core.pragma('dart2js:noInline')
  static Time getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Time>(create);
  static Time? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get start => $_getSZ(0);
  @$pb.TagNumber(1)
  set start($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get end => $_getSZ(1);
  @$pb.TagNumber(2)
  set end($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
}

enum Condition_SchedType {
  type, 
  day, 
  time, 
  notSet
}

class Condition extends $pb.GeneratedMessage {
  factory Condition({
    Aggregate? type,
    Cron? day,
    Time? time,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (day != null) {
      $result.day = day;
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  Condition._() : super();
  factory Condition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Condition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Condition_SchedType> _Condition_SchedTypeByTag = {
    1 : Condition_SchedType.type,
    2 : Condition_SchedType.day,
    3 : Condition_SchedType.time,
    0 : Condition_SchedType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Condition', createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Aggregate>(1, _omitFieldNames ? '' : 'type', subBuilder: Aggregate.create)
    ..aOM<Cron>(2, _omitFieldNames ? '' : 'day', subBuilder: Cron.create)
    ..aOM<Time>(3, _omitFieldNames ? '' : 'time', subBuilder: Time.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Condition clone() => Condition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Condition copyWith(void Function(Condition) updates) => super.copyWith((message) => updates(message as Condition)) as Condition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Condition create() => Condition._();
  Condition createEmptyInstance() => create();
  static $pb.PbList<Condition> createRepeated() => $pb.PbList<Condition>();
  @$core.pragma('dart2js:noInline')
  static Condition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Condition>(create);
  static Condition? _defaultInstance;

  Condition_SchedType whichSchedType() => _Condition_SchedTypeByTag[$_whichOneof(0)]!;
  void clearSchedType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Aggregate get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Aggregate v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);
  @$pb.TagNumber(1)
  Aggregate ensureType() => $_ensure(0);

  @$pb.TagNumber(2)
  Cron get day => $_getN(1);
  @$pb.TagNumber(2)
  set day(Cron v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDay() => $_has(1);
  @$pb.TagNumber(2)
  void clearDay() => clearField(2);
  @$pb.TagNumber(2)
  Cron ensureDay() => $_ensure(1);

  @$pb.TagNumber(3)
  Time get time => $_getN(2);
  @$pb.TagNumber(3)
  set time(Time v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
  @$pb.TagNumber(3)
  Time ensureTime() => $_ensure(2);
}

class Confirmation extends $pb.GeneratedMessage {
  factory Confirmation({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Confirmation._() : super();
  factory Confirmation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Confirmation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Confirmation', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Confirmation clone() => Confirmation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Confirmation copyWith(void Function(Confirmation) updates) => super.copyWith((message) => updates(message as Confirmation)) as Confirmation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Confirmation create() => Confirmation._();
  Confirmation createEmptyInstance() => create();
  static $pb.PbList<Confirmation> createRepeated() => $pb.PbList<Confirmation>();
  @$core.pragma('dart2js:noInline')
  static Confirmation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Confirmation>(create);
  static Confirmation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
