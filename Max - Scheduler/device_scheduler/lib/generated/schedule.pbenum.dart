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

class Aggregate_Type extends $pb.ProtobufEnum {
  static const Aggregate_Type AND = Aggregate_Type._(0, _omitEnumNames ? '' : 'AND');
  static const Aggregate_Type OR = Aggregate_Type._(1, _omitEnumNames ? '' : 'OR');

  static const $core.List<Aggregate_Type> values = <Aggregate_Type> [
    AND,
    OR,
  ];

  static final $core.Map<$core.int, Aggregate_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Aggregate_Type? valueOf($core.int value) => _byValue[value];

  const Aggregate_Type._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
