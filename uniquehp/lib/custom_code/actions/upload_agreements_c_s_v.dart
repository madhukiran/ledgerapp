// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

Future<String> uploadAgreementsCSV() async {
  // upload a csv file and return the content

  var databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'uniquehp.db');
  Database database = await openDatabase(dbPath);

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );
  int index = 0;

  try {
    //List<String> outputStrList = [];
    if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files[0];
        String csvString = await File(file.path!).readAsString();
        List<List<dynamic>> csvTable =
            const CsvToListConverter().convert(csvString, fieldDelimiter: '|');

        await database.execute('DELETE FROM hp_summary');
        await database.execute('DELETE FROM hp_detail');
        await database.execute('DELETE FROM hp_header');
        Batch batch = database.batch();
        for (int i = 0; i < csvTable.length; i++) {
          if(i == 651)
            index = i;
          if(csvTable[i][0] == "hs")
          {
            batch.insert(
              'hp_summary',
              {
                'id': csvTable[i][1],
                'F_COMP_ID': csvTable[i][2],
                'F_COMPCODE': csvTable[i][3],
                'F_CONT_NO': csvTable[i][4],
                'F_HRR_NAME': csvTable[i][5],
                'F_VHC_NAME': csvTable[i][6],
                'F_REGSNO': csvTable[i][7],
                'F_MOBILE': csvTable[i][8],
                'F_CH_ADD1': csvTable[i][9],
                'F_CLOSED': csvTable[i][10],
                'F_ONLY_VNO': csvTable[i][11],
                'F_DLM': csvTable[i][12],
                'F_USER_ID': csvTable[i][13]
              },
            );
          } // hp_summary table
          else if(csvTable[i][0] == "hd")
          {
            batch.insert(
              'hp_detail',
              {
                'F_COMP_ID': csvTable[i][1],
                'F_CONT_NO': csvTable[i][2],
                'F_RECORDNO': csvTable[i][3],
                'F_INS_NO': csvTable[i][4],
                'F_DUE_AM': csvTable[i][5],
                'F_DUE_DT': csvTable[i][6],
                'F_RECD_AM': csvTable[i][7],
                'F_RECD_DT': csvTable[i][8],
                'F_DEL_DAYS': csvTable[i][9],
                'F_DEL_MON': csvTable[i][10],
                'F_DETAILS': csvTable[i][11],
                'F_BALANCE': csvTable[i][12],
                'F_OD': csvTable[i][13],
                'F_OD2': csvTable[i][14],
                'F_COL1': csvTable[i][15],
                'F_COL2': csvTable[i][16],
                'F_COL3': csvTable[i][17],
                'F_COL4': csvTable[i][18],
                'F_COL5': csvTable[i][19],
                'F_COL6': csvTable[i][20]
              },
            );
          } // hp_detail table
          else if(csvTable[i][0] == "hh")
          {
            batch.insert(
              'hp_header',
              {
                'F_COMP_ID': csvTable[i][1],
                'F_LOAN_TP': csvTable[i][2],
                'F_CONT_NO': csvTable[i][3],
                'F_COMPNAME': csvTable[i][4],
                'F_FILE_NO': csvTable[i][5],
                'F_REGSNO': csvTable[i][6],
                'F_CHASNO': csvTable[i][7],
                'F_ENGNBR': csvTable[i][8],
                'F_VHC_NAME': csvTable[i][9],
                'F_MODEL': csvTable[i][10],
                'F_BRK_NAME': csvTable[i][11],
                'F_CONT_DT': csvTable[i][12],
                'F_FIN_AM': csvTable[i][13],
                'F_FIN_RT': csvTable[i][14],
                'F_CNT_PRD': csvTable[i][15],
                'F_FIN_CH': csvTable[i][16],
                'F_INS_DP': csvTable[i][17],
                'F_CONT_AM': csvTable[i][18],
                'F_HRR_NAME': csvTable[i][19],
                'F_HRR_FHG': csvTable[i][20],
                'F_HRR_ADD1': csvTable[i][21],
                'F_HRR_ADD2': csvTable[i][22],
                'F_HRR_ADD3': csvTable[i][23],
                'F_HRR_ADD4': csvTable[i][24],
                'F_HRR_PH': csvTable[i][25],
                'F_GRN_NAME': csvTable[i][26],
                'F_GRN_FHG': csvTable[i][27],
                'F_GRN_ADD1': csvTable[i][28],
                'F_GRN_ADD2': csvTable[i][29],
                'F_GRN_ADD3': csvTable[i][30],
                'F_GRN_ADD4': csvTable[i][31],
                'F_GRN_PH': csvTable[i][32],
                'F_ETC1': csvTable[i][33],
                'F_ETC2': csvTable[i][34],
                'F_ETC3': csvTable[i][35],
                'F_ETC4': csvTable[i][36],
                'F_ETC5': csvTable[i][37],
                'F_ETC6': csvTable[i][38]
              },
            );
          } // hp_header table
          else {
            return "Invalid file name. Contact vendor";
          }
          index = i;
        }
        await batch.commit();


        // if (file.name == "hp_summary.csv") {
        //   await database.execute('DELETE FROM hp_summary');
        //   // Insert data into table.
        //   Batch batch = database.batch();
        //   for (int i = 1; i < csvTable.length; i++) {
        //     batch.insert(
        //       'hp_summary',
        //       {
        //         'id': csvTable[i][0],
        //         'F_COMP_ID': csvTable[i][1],
        //         'F_COMPCODE': csvTable[i][2],
        //         'F_CONT_NO': csvTable[i][3],
        //         'F_HRR_NAME': csvTable[i][4],
        //         'F_VHC_NAME': csvTable[i][5],
        //         'F_REGSNO': csvTable[i][6],
        //         'F_MOBILE': csvTable[i][7],
        //         'F_CH_ADD1': csvTable[i][8],
        //         'F_CLOSED': csvTable[i][9],
        //         'F_ONLY_VNO': csvTable[i][10],
        //         'F_DLM': csvTable[i][11],
        //         'F_USER_ID': csvTable[i][12],
        //       },
        //     );
        //   }
        //   await batch.commit();
        //   outputStrList.add(file.name);
        //   //return 'Updated hp_summary'; // Indicate that the upload was successful
        // } else if (file.name == "hp_detail.csv") {
        //   await database.execute('DELETE FROM hp_detail');

        //   // Insert data into table.
        //   Batch batch = database.batch();
        //   for (int i = 1; i < csvTable.length; i++) {
        //     batch.insert(
        //       'hp_detail',
        //       {
        //         'F_COMP_ID': csvTable[i][0],
        //         'F_CONT_NO': csvTable[i][1],
        //         'F_RECORDNO': csvTable[i][2],
        //         'F_INS_NO': csvTable[i][3],
        //         'F_DUE_AM': csvTable[i][4],
        //         'F_DUE_DT': csvTable[i][5],
        //         'F_RECD_AM': csvTable[i][6],
        //         'F_RECD_DT': csvTable[i][7],
        //         'F_DEL_DAYS': csvTable[i][8],
        //         'F_DEL_MON': csvTable[i][9],
        //         'F_DETAILS': csvTable[i][10],
        //         'F_BALANCE': csvTable[i][11],
        //         'F_OD': csvTable[i][12],
        //         'F_OD2': csvTable[i][13],
        //         'F_COL1': csvTable[i][14],
        //         'F_COL2': csvTable[i][15],
        //         'F_COL3': csvTable[i][16],
        //         'F_COL4': csvTable[i][17],
        //         'F_COL5': csvTable[i][18],
        //         'F_COL6': csvTable[i][19],
        //       },
        //     );
        //   }
        //   await batch.commit();
        //   outputStrList.add(file.name);
        //   //return 'Updated hp_detail'; // Indicate that the upload was successful
        // } else if (file.name == "hp_header.csv") {
        //   await database.execute('DELETE FROM hp_header');

        //   // Insert data into table.
        //   Batch batch = database.batch();
        //   for (int i = 1; i < csvTable.length; i++) {
        //     batch.insert(
        //       'hp_header',
        //       {
        //         'F_COMP_ID': csvTable[i][0],
        //         'F_LOAN_TP': csvTable[i][1],
        //         'F_CONT_NO': csvTable[i][2],
        //         'F_COMPNAME': csvTable[i][3],
        //         'F_FILE_NO': csvTable[i][4],
        //         'F_REGSNO': csvTable[i][5],
        //         'F_CHASNO': csvTable[i][6],
        //         'F_ENGNBR': csvTable[i][7],
        //         'F_VHC_NAME': csvTable[i][8],
        //         'F_MODEL': csvTable[i][9],
        //         'F_BRK_NAME': csvTable[i][10],
        //         'F_CONT_DT': csvTable[i][11],
        //         'F_FIN_AM': csvTable[i][12],
        //         'F_FIN_RT': csvTable[i][13],
        //         'F_CNT_PRD': csvTable[i][14],
        //         'F_FIN_CH': csvTable[i][15],
        //         'F_INS_DP': csvTable[i][16],
        //         'F_CONT_AM': csvTable[i][17],
        //         'F_HRR_NAME': csvTable[i][18],
        //         'F_HRR_FHG': csvTable[i][19],
        //         'F_HRR_ADD1': csvTable[i][20],
        //         'F_HRR_ADD2': csvTable[i][21],
        //         'F_HRR_ADD3': csvTable[i][22],
        //         'F_HRR_ADD4': csvTable[i][23],
        //         'F_HRR_PH': csvTable[i][24],
        //         'F_GRN_NAME': csvTable[i][25],
        //         'F_GRN_FHG': csvTable[i][26],
        //         'F_GRN_ADD1': csvTable[i][27],
        //         'F_GRN_ADD2': csvTable[i][28],
        //         'F_GRN_ADD3': csvTable[i][29],
        //         'F_GRN_ADD4': csvTable[i][30],
        //         'F_GRN_PH': csvTable[i][31],
        //         'F_ETC1': csvTable[i][32],
        //         'F_ETC2': csvTable[i][33],
        //         'F_ETC3': csvTable[i][34],
        //         'F_ETC4': csvTable[i][35],
        //         'F_ETC5': csvTable[i][36],
        //         'F_ETC6': csvTable[i][37],
        //       },
        //     );
        //   }
        //   await batch.commit();
        //   outputStrList.add(file.name);
        //   //return 'Updated hp_header'; // Indicate that the upload was successful
        // } else {
        //   print('Invalid file name. Ignoring it: ${file.name}');
        // }
    }
    return 'Successfully updated';
  } catch (e) {
    return 'Error reading file: $e. Index: $index';
  }
}
