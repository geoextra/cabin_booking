import 'dart:collection';
import 'dart:convert' show json;

import 'package:cabin_booking/model/file_manager.dart';
import 'package:cabin_booking/model/school_year.dart';
import 'package:cabin_booking/model/writable_manager.dart';
import 'package:flutter/foundation.dart';

Iterable<SchoolYear> _parseSchoolYears(String jsonString) =>
    json.decode(jsonString).map<SchoolYear>((json) => SchoolYear.from(json));

class SchoolYearManager extends WritableManager<Set<SchoolYear>>
    with ChangeNotifier, FileManager {
  Set<SchoolYear> schoolYears;
  int schoolYearIndex;

  SchoolYearManager({
    this.schoolYears,
    String fileName = 'school_year_manager',
  }) : super(fileName) {
    schoolYears ??= SplayTreeSet();
    schoolYearIndex = _currentSchoolYearIndex;
  }

  List<Map<String, dynamic>> schoolYearsToMapList() =>
      schoolYears.map((schoolYear) => schoolYear.toMap()).toList();

  int get _currentSchoolYearIndex => _schoolYearIndexFrom(DateTime.now());

  int _schoolYearIndexFrom(DateTime dateTime) {
    if (schoolYears.isEmpty) return null;

    for (var i = 0; i < schoolYears.length - 1; i++) {
      if (dateTime.isAfter(schoolYears.elementAt(i).startDate) &&
          dateTime.isBefore(schoolYears.elementAt(i + 1).startDate)) {
        return i;
      }
    }

    return schoolYears.length - 1;
  }

  SchoolYear get schoolYear => schoolYears.elementAt(schoolYearIndex);

  void changeToPreviousSchoolYear() =>
      schoolYearIndex = schoolYearIndex > 0 ? schoolYearIndex - 1 : 0;

  void changeToCurrentSchoolYear() => schoolYearIndex = _currentSchoolYearIndex;

  void changeToSchoolYearFrom(DateTime dateTime) =>
      schoolYearIndex = _schoolYearIndexFrom(dateTime);

  void changeToNextSchoolYear() =>
      schoolYearIndex = schoolYearIndex < schoolYears.length - 1
          ? schoolYearIndex + 1
          : schoolYears.length - 1;

  @override
  Future<Set<SchoolYear>> readFromFile() async {
    try {
      final file = await localFile(fileName);
      final content = await file.readAsString();

      final schoolYears = await _parseSchoolYears(content);

      return SplayTreeSet.from(schoolYears);
    } catch (e) {
      return SplayTreeSet();
    }
  }

  @override
  Future<int> loadFromFile() async {
    schoolYears = await readFromFile();

    notifyListeners();

    return schoolYears.length;
  }

  @override
  Future<bool> writeToFile() async {
    final file = await localFile(fileName);

    await file.writeAsString(
      json.encode(schoolYearsToMapList()),
    );

    return true;
  }
}
