//
//  Generated code. Do not modify.
//  source: schedule.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use aggregateDescriptor instead')
const Aggregate$json = {
  '1': 'Aggregate',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.Aggregate.Type', '10': 'type'},
    {'1': 'conditions', '3': 2, '4': 3, '5': 11, '6': '.Condition', '10': 'conditions'},
  ],
  '4': [Aggregate_Type$json],
};

@$core.Deprecated('Use aggregateDescriptor instead')
const Aggregate_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'AND', '2': 0},
    {'1': 'OR', '2': 1},
  ],
};

/// Descriptor for `Aggregate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aggregateDescriptor = $convert.base64Decode(
    'CglBZ2dyZWdhdGUSIwoEdHlwZRgBIAEoDjIPLkFnZ3JlZ2F0ZS5UeXBlUgR0eXBlEioKCmNvbm'
    'RpdGlvbnMYAiADKAsyCi5Db25kaXRpb25SCmNvbmRpdGlvbnMiFwoEVHlwZRIHCgNBTkQQABIG'
    'CgJPUhAB');

@$core.Deprecated('Use cronDescriptor instead')
const Cron$json = {
  '1': 'Cron',
  '2': [
    {'1': 'cron', '3': 1, '4': 1, '5': 9, '10': 'cron'},
  ],
};

/// Descriptor for `Cron`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cronDescriptor = $convert.base64Decode(
    'CgRDcm9uEhIKBGNyb24YASABKAlSBGNyb24=');

@$core.Deprecated('Use timeDescriptor instead')
const Time$json = {
  '1': 'Time',
  '2': [
    {'1': 'start', '3': 1, '4': 1, '5': 9, '10': 'start'},
    {'1': 'end', '3': 2, '4': 1, '5': 9, '10': 'end'},
  ],
};

/// Descriptor for `Time`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeDescriptor = $convert.base64Decode(
    'CgRUaW1lEhQKBXN0YXJ0GAEgASgJUgVzdGFydBIQCgNlbmQYAiABKAlSA2VuZA==');

@$core.Deprecated('Use conditionDescriptor instead')
const Condition$json = {
  '1': 'Condition',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 11, '6': '.Aggregate', '9': 0, '10': 'type'},
    {'1': 'day', '3': 2, '4': 1, '5': 11, '6': '.Cron', '9': 0, '10': 'day'},
    {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.Time', '9': 0, '10': 'time'},
  ],
  '8': [
    {'1': 'SchedType'},
  ],
};

/// Descriptor for `Condition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List conditionDescriptor = $convert.base64Decode(
    'CglDb25kaXRpb24SIAoEdHlwZRgBIAEoCzIKLkFnZ3JlZ2F0ZUgAUgR0eXBlEhkKA2RheRgCIA'
    'EoCzIFLkNyb25IAFIDZGF5EhsKBHRpbWUYAyABKAsyBS5UaW1lSABSBHRpbWVCCwoJU2NoZWRU'
    'eXBl');

@$core.Deprecated('Use confirmationDescriptor instead')
const Confirmation$json = {
  '1': 'Confirmation',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Confirmation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmationDescriptor = $convert.base64Decode(
    'CgxDb25maXJtYXRpb24SGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

