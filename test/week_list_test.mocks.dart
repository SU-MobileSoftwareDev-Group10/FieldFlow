// Mocks generated by Mockito 5.4.5 from annotations
// in field_flow/test/week_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:field_flow/db/firestore_helper.dart' as _i3;
import 'package:field_flow/model/day_model.dart' as _i7;
import 'package:field_flow/model/location_model.dart' as _i6;
import 'package:field_flow/model/week_model.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDocumentSnapshot_0<T extends Object?> extends _i1.SmartFake
    implements _i2.DocumentSnapshot<T> {
  _FakeDocumentSnapshot_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [FirestoreHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirestoreHelper extends _i1.Mock implements _i3.FirestoreHelper {
  MockFirestoreHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<Map<String, dynamic>>> fetchUsers() =>
      (super.noSuchMethod(
            Invocation.method(#fetchUsers, []),
            returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[],
            ),
          )
          as _i4.Future<List<Map<String, dynamic>>>);

  @override
  _i4.Future<String> saveCheckIn(DateTime? checkInTime) =>
      (super.noSuchMethod(
            Invocation.method(#saveCheckIn, [checkInTime]),
            returnValue: _i4.Future<String>.value(
              _i5.dummyValue<String>(
                this,
                Invocation.method(#saveCheckIn, [checkInTime]),
              ),
            ),
          )
          as _i4.Future<String>);

  @override
  _i4.Future<void> saveCheckOut(
    String? entryId,
    DateTime? checkOutTime,
    List<_i6.LocationModel>? locations,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#saveCheckOut, [
              entryId,
              checkOutTime,
              locations,
            ]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Stream<List<_i7.DayModel>> getDaysStream({required String? userId}) =>
      (super.noSuchMethod(
            Invocation.method(#getDaysStream, [], {#userId: userId}),
            returnValue: _i4.Stream<List<_i7.DayModel>>.empty(),
          )
          as _i4.Stream<List<_i7.DayModel>>);

  @override
  _i4.Stream<List<_i8.WeekModel>> getWeeksStream({required String? userId}) =>
      (super.noSuchMethod(
            Invocation.method(#getWeeksStream, [], {#userId: userId}),
            returnValue: _i4.Stream<List<_i8.WeekModel>>.empty(),
          )
          as _i4.Stream<List<_i8.WeekModel>>);

  @override
  _i4.Future<_i2.DocumentSnapshot<Object?>> getUser(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getUser, [userId]),
            returnValue: _i4.Future<_i2.DocumentSnapshot<Object?>>.value(
              _FakeDocumentSnapshot_0<Object?>(
                this,
                Invocation.method(#getUser, [userId]),
              ),
            ),
          )
          as _i4.Future<_i2.DocumentSnapshot<Object?>>);

  @override
  _i4.Future<void> createUser(String? userId, String? name, String? email) =>
      (super.noSuchMethod(
            Invocation.method(#createUser, [userId, name, email]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<Map<String, String>> getUsers() =>
      (super.noSuchMethod(
            Invocation.method(#getUsers, []),
            returnValue: _i4.Future<Map<String, String>>.value(
              <String, String>{},
            ),
          )
          as _i4.Future<Map<String, String>>);

  @override
  _i4.Future<List<Map<String, dynamic>>> getWorkHourReport({
    required List<String>? userIds,
    required DateTime? startDate,
    required DateTime? endDate,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getWorkHourReport, [], {
              #userIds: userIds,
              #startDate: startDate,
              #endDate: endDate,
            }),
            returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[],
            ),
          )
          as _i4.Future<List<Map<String, dynamic>>>);

  @override
  _i4.Future<Map<String, List<Map<String, dynamic>>>> fetchReportData({
    required List<String>? userIds,
    required DateTime? startDate,
    required DateTime? endDate,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#fetchReportData, [], {
              #userIds: userIds,
              #startDate: startDate,
              #endDate: endDate,
            }),
            returnValue:
                _i4.Future<Map<String, List<Map<String, dynamic>>>>.value(
                  <String, List<Map<String, dynamic>>>{},
                ),
          )
          as _i4.Future<Map<String, List<Map<String, dynamic>>>>);
}
