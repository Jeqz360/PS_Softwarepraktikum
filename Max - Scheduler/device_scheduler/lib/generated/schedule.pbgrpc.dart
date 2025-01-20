//
//  Generated code. Do not modify.
//  source: schedule.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'schedule.pb.dart' as $0;

export 'schedule.pb.dart';

@$pb.GrpcServiceName('SendCondition')
class SendConditionClient extends $grpc.Client {
  static final _$sendCondition = $grpc.ClientMethod<$0.Condition, $0.Confirmation>(
      '/SendCondition/SendCondition',
      ($0.Condition value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Confirmation.fromBuffer(value));

  SendConditionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Confirmation> sendCondition($0.Condition request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendCondition, request, options: options);
  }
}

@$pb.GrpcServiceName('SendCondition')
abstract class SendConditionServiceBase extends $grpc.Service {
  $core.String get $name => 'SendCondition';

  SendConditionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Condition, $0.Confirmation>(
        'SendCondition',
        sendCondition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Condition.fromBuffer(value),
        ($0.Confirmation value) => value.writeToBuffer()));
  }

  $async.Future<$0.Confirmation> sendCondition_Pre($grpc.ServiceCall call, $async.Future<$0.Condition> request) async {
    return sendCondition(call, await request);
  }

  $async.Future<$0.Confirmation> sendCondition($grpc.ServiceCall call, $0.Condition request);
}
