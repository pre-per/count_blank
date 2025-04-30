import 'package:count_bath/widget/dropzone_widget.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:count_bath/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = FutureProvider<List<User>>((ref) async {
  final file = ref.watch(fileProvider);

  if (file == null) return [];

  // -----------------------
  // 엑셀 파일 불러오기
  // -----------------------

  final bytes = await file.readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);
  final sheet = excel.tables[excel.tables.keys.first];

  if (sheet == null) return [];

  final rows = sheet.rows;

  if (rows.isEmpty) return [];

  // ------------------------
  // 헤더에서 이름, 장애 유형, 장애 정도 열 찾기
  // ------------------------

  final header = rows.first;
  int nameIdx = -1;
  int disabilityTypeIdx = -1;
  int severityIdx = -1;

  for (int i = 0; i < header.length; i++) {
    final headerName = header[i]?.value?.toString() ?? '';

    if (headerName == '성명') {
      nameIdx = i;
    } else if (headerName == '금년생일') {
      disabilityTypeIdx = i;
    } else if (headerName == '금년기념') {
      severityIdx = i;
    }
  }

  if (nameIdx == -1 || disabilityTypeIdx == -1 || severityIdx == -1) {
    throw Exception('필수 열(이름/금년기념/금년생일)을 찾을 수 없습니다.');
  }

  // --------------------
  // User 모델화하기
  // --------------------

  List<User> users = [];

  for (int i = 1; i < rows.length; i++) {
    final row = rows[i];
    final rawSeverity = row[severityIdx]?.value?.toString() ?? 'Unknown';
    final rawDisability = row[disabilityTypeIdx]?.value?.toString() ?? 'Unknown';

    users.add(
      User(
        name: row[nameIdx]?.value?.toString() ?? 'Unknown',
        severity: _processSeverity(rawSeverity),
        disabilityType: _processDisability(rawDisability),
        rowNumber: i+1,
      ),
    );
    /*
    print(row[nameIdx]?.value?.toString() ?? 'Unknown');
    print(_processSeverity(rawSeverity));
    print(_processDisability(rawDisability));
    print(i+1);
    print("---------"); */
  }

  return users;
});

// -------------
// 장애 정도 분류 함수
// -------------

String _processSeverity(dynamic rawSeverity) {
  final value = rawSeverity?.toString().trim() ?? '';

  if (['1', '2', '3', '중증'].contains(value)) {
    return '중증';
  } else if (['4', '5', '6', '경증'].contains(value)) {
    return '경증';
  } else if (['보호', '보호자'].contains(value)){
    return '보호자';
  } else {
    return '기타';
  }
}

String _processDisability(dynamic rawDisability) {
  final value = rawDisability?.toString().trim() ?? '';

  if (value.contains('지체')) {
    return '지체장애';
  } else if (value.contains('청각')){
    return '청각장애';
  } else if (value.contains('보호자')){
    return '보호자';
  } else if (value.contains('시각')){
    return '시각장애';
  } else if (value.contains('뇌병변') || value.contains('간질')){
    return '뇌병변장애';
  } else if (value.contains('지적')) {
    return '지적장애';
  } else if (value.contains('정신')) {
    return '정신장애';
  } else if (value.contains('신장')) {
    return '신장장애';
  } else if (value.contains('자폐')) {
    return '자폐성장애';
  } else if (value.contains('호흡기')) {
    return '호흡기장애';
  } else if (value.contains('장루')) {
    return '장루장애';
  } else if (value.contains('심장')) {
    return '심장장애';
  } else if (value.contains('간')) {
    return '간장애';
  } else {
    return '기타';
  }
}