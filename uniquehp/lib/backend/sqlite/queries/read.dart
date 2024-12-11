import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN SEARCH QUERY
Future<List<SearchQueryRow>> performSearchQuery(
  Database database, {
  String? columnName,
  int? limitCount,
  String? searchVal,
}) {
  final query = '''
SELECT F_COMP_ID, COALESCE(F_CONT_NO,'') AS F_CONT_NO, COALESCE(F_REGSNO,'') AS F_REGSNO, COALESCE(F_VHC_NAME,'') AS F_VHC_NAME,
COALESCE(F_HRR_NAME,'') AS F_HRR_NAME, CAST(COALESCE(F_MOBILE,0) AS INTEGER) AS F_MOBILE, F_COMPCODE, F_ONLY_VNO
FROM hp_summary
WHERE ${columnName} LIKE '%${searchVal}%'
ORDER BY ${columnName}
LIMIT ${limitCount};
''';
  return _readQuery(database, query, (d) => SearchQueryRow(d));
}

class SearchQueryRow extends SqliteRow {
  SearchQueryRow(Map<String, dynamic> data) : super(data);

  int get fCompId => data['F_COMP_ID'] as int;
  String get fContNo => data['F_CONT_NO'] as String;
  String get fRegsno => data['F_REGSNO'] as String;
  String get fVhcName => data['F_VHC_NAME'] as String;
  String get fHrrName => data['F_HRR_NAME'] as String;
  int get fMobile => data['F_MOBILE'] as int;
  String get fCompcode => data['F_COMPCODE'] as String;
  int get fOnlyVno => data['F_ONLY_VNO'] as int;
}

/// END SEARCH QUERY

/// BEGIN INITIALQUERY
Future<List<InitialQueryRow>> performInitialQuery(
  Database database,
) {
  final query = '''
SELECT F_COMP_ID, F_CONT_NO, F_REGSNO, F_VHC_NAME, F_HRR_NAME, F_MOBILE, F_COMPCODE, F_ONLY_VNO 
FROM hp_summary
LIMIT 10;
''';
  return _readQuery(database, query, (d) => InitialQueryRow(d));
}

class InitialQueryRow extends SqliteRow {
  InitialQueryRow(Map<String, dynamic> data) : super(data);

  int? get compId => data['COMP_ID'] as int?;
  String? get registrationNO => data['RegistrationNO'] as String?;
  String? get hirerName => data['HirerName'] as String?;
  String? get vehcileName => data['VehcileName'] as String?;
  String? get mobile => data['Mobile'] as String?;
  String? get agrNo => data['AgrNo'] as String?;
  String? get company => data['Company'] as String?;
  String? get onlyVehcileNo => data['Only_Vehcile_No'] as String?;
}

/// END INITIALQUERY

/// BEGIN HEADERQUERY
Future<List<HeaderQueryRow>> performHeaderQuery(
  Database database, {
  int? compId,
  String? contNo,
}) {
  final query = '''
SELECT
    COALESCE(F_GRN_NAME, '') AS F_GRN_NAME,
    COALESCE(F_GRN_FHG, '') AS F_GRN_FHG,
    COALESCE(F_GRN_ADD1, '') AS F_GRN_ADD1,
    COALESCE(F_GRN_ADD2, '') AS F_GRN_ADD2,
    COALESCE(F_GRN_ADD3, '') AS F_GRN_ADD3,
    COALESCE(F_GRN_ADD4, '') AS F_GRN_ADD4,
    COALESCE(F_GRN_PH, '') AS F_GRN_PH,
    COALESCE(F_HRR_NAME, '') AS F_HRR_NAME,
    COALESCE(F_HRR_FHG, '') AS F_HRR_FHG,
    COALESCE(F_HRR_ADD1, '') AS F_HRR_ADD1,
    COALESCE(F_HRR_ADD2, '') AS F_HRR_ADD2,
    COALESCE(F_HRR_ADD3, '') AS F_HRR_ADD3,
    COALESCE(F_HRR_ADD4, '') AS F_HRR_ADD4,
    COALESCE(F_HRR_PH, '') AS F_HRR_PH,
    COALESCE(F_MODEL, '') AS F_MODEL,
    COALESCE(F_FILE_NO, '') AS F_FILE_NO,
    COALESCE(F_VHC_NAME, '') AS F_VHC_NAME,
    COALESCE(F_REGSNO, '') AS F_REGSNO,
CASE WHEN F_INS_DP IS NULL THEN 0 ELSE ROUND(F_INS_DP, 2) END AS F_INS_DP,
    COALESCE(F_CONT_DT, '') AS F_CONT_DT,
    COALESCE(F_BRK_NAME, '') AS F_BRK_NAME,
    COALESCE(F_ETC6, '') AS F_ETC6,
    COALESCE(F_CHASNO, '') AS F_CHASNO,
    COALESCE(F_ENGNBR, '') AS F_ENGNBR,
    COALESCE(F_COMPNAME, '') AS F_COMPNAME,
    CASE WHEN F_FIN_AM IS NULL THEN 0 ELSE ROUND(F_FIN_AM, 2) END AS F_FIN_AM,
    CAST(COALESCE(F_FIN_RT, 0) AS REAL) AS F_FIN_RT,
    CASE WHEN F_CNT_PRD IS NULL THEN 0 ELSE F_CNT_PRD END AS F_CNT_PRD,
    CASE WHEN F_FIN_CH IS NULL THEN 0 ELSE ROUND(F_FIN_CH, 2) END AS F_FIN_CH,
    CASE WHEN F_CONT_AM IS NULL THEN 0 ELSE ROUND(F_CONT_AM, 2) END AS F_CONT_AM
FROM
    hp_header
WHERE
    F_COMP_ID = ${compId} AND
    F_CONT_NO = '${contNo}';
''';
  return _readQuery(database, query, (d) => HeaderQueryRow(d));
}

class HeaderQueryRow extends SqliteRow {
  HeaderQueryRow(Map<String, dynamic> data) : super(data);

  String? get fGrnName => data['F_GRN_NAME'] as String?;
  String? get fGrnFhg => data['F_GRN_FHG'] as String?;
  String? get fGrnAdd1 => data['F_GRN_ADD1'] as String?;
  String? get fGrnAdd2 => data['F_GRN_ADD2'] as String?;
  String? get fGrnAdd3 => data['F_GRN_ADD3'] as String?;
  String? get fGrnAdd4 => data['F_GRN_ADD4'] as String?;
  String? get fGrnPh => data['F_GRN_PH'] as String?;
  String? get fHrrName => data['F_HRR_NAME'] as String?;
  String? get fHrrFhg => data['F_HRR_FHG'] as String?;
  String? get fHrrAdd1 => data['F_HRR_ADD1'] as String?;
  String? get fHrrAdd2 => data['F_HRR_ADD2'] as String?;
  String? get fHrrAdd3 => data['F_HRR_ADD3'] as String?;
  String? get fHrrAdd4 => data['F_HRR_ADD4'] as String?;
  String? get fHrrPh => data['F_HRR_PH'] as String?;
  String? get fModel => data['F_MODEL'] as String?;
  String? get fFileNo => data['F_FILE_NO'] as String?;
  String? get fVhcName => data['F_VHC_NAME'] as String?;
  String? get fRegsno => data['F_REGSNO'] as String?;
  double? get fFinRt => data['F_FIN_RT'] as double?;
  double? get fFinCh => data['F_FIN_CH'] as double?;
  int? get fCntPrd => data['F_CNT_PRD'] as int?;
  double? get fInsDp => data['F_INS_DP'] as double?;
  String? get fContDt => data['F_CONT_DT'] as String?;
  double? get fContAm => data['F_CONT_AM'] as double?;
  double? get fFinAm => data['F_FIN_AM'] as double?;
  String? get fBrkName => data['F_BRK_NAME'] as String?;
  String? get fChasno => data['F_CHASNO'] as String?;
  String? get fEngnbr => data['F_ENGNBR'] as String?;
  String? get fCompname => data['F_COMPNAME'] as String?;
  String? get fEtc6 => data['F_ETC6'] as String?;
}

/// END HEADERQUERY

/// BEGIN DETAILSQUERY
Future<List<DetailsQueryRow>> performDetailsQuery(
  Database database, {
  int? compId,
  String? contNo,
}) {
  final query = '''
SELECT
    CASE WHEN F_RECORDNO IS NULL THEN 0 ELSE F_RECORDNO END AS F_RECORDNO,
    CASE WHEN F_INS_NO IS NULL THEN 0 ELSE F_INS_NO END AS F_INS_NO,
    CASE WHEN F_DUE_AM IS NULL THEN 0 ELSE ROUND(F_DUE_AM, 2) END AS F_DUE_AM,
    COALESCE(F_DUE_DT, '') AS F_DUE_DT,
    CASE WHEN F_RECD_AM IS NULL THEN 0 ELSE ROUND(F_RECD_AM, 2) END AS F_RECD_AM,
    COALESCE(F_RECD_DT, '') AS F_RECD_DT,
    CASE WHEN F_DEL_DAYS IS NULL THEN 0 ELSE F_DEL_DAYS END AS F_DEL_DAYS,
    CASE WHEN F_DEL_MON IS NULL THEN 0 ELSE F_DEL_MON END AS F_DEL_MON,
    COALESCE(F_DETAILS, '') AS F_DETAILS,
    CASE WHEN F_BALANCE IS NULL THEN 0 ELSE ROUND(F_BALANCE, 2) END AS F_BALANCE,
    CASE WHEN F_OD IS NULL THEN 0 ELSE ROUND(F_OD, 2) END AS F_OD,
    CASE WHEN F_OD2 IS NULL THEN 0 ELSE ROUND(F_OD2, 2) END AS F_OD2,
    COALESCE(F_COL1, '') AS F_COL1,
    COALESCE(F_COL2, '') AS F_COL2,
    COALESCE(F_COL3, '') AS F_COL3,
    COALESCE(F_COL4, '') AS F_COL4,
    COALESCE(F_COL5, '') AS F_COL5,
    COALESCE(F_COL6, '') AS F_COL6
FROM
    hp_detail
WHERE
    F_COMP_ID = ${compId} AND
    F_CONT_NO = '${contNo}'
ORDER BY F_RECORDNO;
''';
  return _readQuery(database, query, (d) => DetailsQueryRow(d));
}

class DetailsQueryRow extends SqliteRow {
  DetailsQueryRow(Map<String, dynamic> data) : super(data);

  int? get fRecordno => data['F_RECORDNO'] as int?;
  int? get fInsNo => data['F_INS_NO'] as int?;
  double? get fDueAm => data['F_DUE_AM'] as double?;
  String? get fDueDt => data['F_DUE_DT'] as String?;
  double? get fRecdAm => data['F_RECD_AM'] as double?;
  String? get fRecdDt => data['F_RECD_DT'] as String?;
  int? get fDelDays => data['F_DEL_DAYS'] as int?;
  int? get fDelMon => data['F_DEL_MON'] as int?;
  String? get fDetails => data['F_DETAILS'] as String?;
  double? get fBalance => data['F_BALANCE'] as double?;
  double? get fOd => data['F_OD'] as double?;
  double? get fOd2 => data['F_OD2'] as double?;
  String? get fCol1 => data['F_COL1'] as String?;
  String? get fCol2 => data['F_COL2'] as String?;
  String? get fCol3 => data['F_COL3'] as String?;
  String? get fCol4 => data['F_COL4'] as String?;
  String? get fCol5 => data['F_COL5'] as String?;
  String? get fCol6 => data['F_COL6'] as String?;
}

/// END DETAILSQUERY
