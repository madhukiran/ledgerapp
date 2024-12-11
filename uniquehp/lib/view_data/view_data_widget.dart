import '/backend/sqlite/sqlite_manager.dart';
import '/components/no_data_component_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'view_data_model.dart';
export 'view_data_model.dart';

class ViewDataWidget extends StatefulWidget {
  /// I want display records from database in a table format
  const ViewDataWidget({super.key});

  @override
  State<ViewDataWidget> createState() => _ViewDataWidgetState();
}

class _ViewDataWidgetState extends State<ViewDataWidget> {
  late ViewDataModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewDataModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.initialSearchQueryResultCopy =
          await SQLiteManager.instance.searchQuery(
        columnName: 'F_ONLY_VNO',
        limitCount: 999999999,
        searchVal: '',
      );
      _model.viewDataTable = [];
      
      _model.viewDataTable =
          _model.initialSearchQueryResultCopy!.toList().cast<SearchQueryRow>();
      safeSetState(() {});
    });

    _model.searchBoxTextController ??= TextEditingController();
    _model.searchBoxFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF6F6F6),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            actions: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: FlutterFlowIconButton(
                      borderRadius: 8,
                      buttonSize: 40,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.settings_sharp,
                        color: FlutterFlowTheme.of(context).info,
                        size: 24,
                      ),
                      onPressed: () async {
                        context.pushNamed('SettingsPage');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 8,
                      buttonSize: 40,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.account_circle,
                        color: FlutterFlowTheme.of(context).info,
                        size: 24,
                      ),
                      onPressed: () async {
                        context.pushNamed('AboutUs');
                      },
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                child: Text(
                  'Unique Systems',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsets.all(4),
            ),
            elevation: 5,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: FlutterFlowRadioButton(
                          options: ['Vehicle Number', 'Hirer Name', 'Mobile']
                              .toList(),
                          onChanged: (val) async {
                            safeSetState(() {});
                            safeSetState(() {
                              _model.searchBoxTextController?.clear();
                            });
                            _model.radioIInitialSearchQuery =
                                await SQLiteManager.instance.searchQuery(
                              columnName: 'F_ONLY_VNO',
                              limitCount: 999999999,
                              searchVal: '',
                            );
                            _model.viewDataTable = [];
                            _model.viewDataTable = _model
                                .radioIInitialSearchQuery!
                                .toList()
                                .cast<SearchQueryRow>();
                            safeSetState(() {});

                            safeSetState(() {});
                          },
                          controller: _model.radioButtonValueController ??=
                              FormFieldController<String>('Vehicle Number'),
                          optionHeight: 32,
                          textStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          selectedTextStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          buttonPosition: RadioButtonPosition.left,
                          direction: Axis.horizontal,
                          radioButtonColor:
                              FlutterFlowTheme.of(context).primary,
                          inactiveRadioButtonColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          toggleable: false,
                          horizontalAlignment: WrapAlignment.start,
                          verticalAlignment: WrapCrossAlignment.start,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextFormField(
                          controller: _model.searchBoxTextController,
                          focusNode: _model.searchBoxFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.searchBoxTextController',
                            Duration(milliseconds: 1000),
                            () async {
                              var _shouldSetState = false;
                              if (_model.searchBoxTextController.text.length ==
                                  0) {
                                _model.initialSearchQueryResult =
                                    await SQLiteManager.instance.searchQuery(
                                  columnName: () {
                                    if (_model.radioButtonValue ==
                                        'Vehicle Number') {
                                      return 'F_ONLY_VNO';
                                    } else if (_model.radioButtonValue ==
                                        'Hirer Name') {
                                      return 'F_HRR_NAME';
                                    } else if (_model.radioButtonValue ==
                                        'Mobile') {
                                      return 'F_MOBILE';
                                    } else {
                                      return 'F_ONLY_VNO';
                                    }
                                  }(),
                                  limitCount: 999999999,
                                  searchVal: '',
                                );
                                _shouldSetState = true;
                                _model.viewDataTable = [];
                                _model.viewDataTable = _model
                                    .initialSearchQueryResult!
                                    .toList()
                                    .cast<SearchQueryRow>();
                              } else if (_model
                                          .searchBoxTextController.text.length >
                                      0 &&
                                  _model.searchBoxTextController.text.length <
                                      4) {
                                _model.searchQueryResult =
                                    await SQLiteManager.instance.searchQuery(
                                  columnName: () {
                                    if (_model.radioButtonValue ==
                                        'Vehicle Number') {
                                      return 'F_ONLY_VNO';
                                    } else if (_model.radioButtonValue ==
                                        'Hirer Name') {
                                      return 'F_HRR_NAME';
                                    } else if (_model.radioButtonValue ==
                                        'Mobile') {
                                      return 'F_MOBILE';
                                    } else {
                                      return 'F_ONLY_VNO';
                                    }
                                  }(),
                                  limitCount: 999999999,
                                  searchVal:
                                      _model.searchBoxTextController.text,
                                );
                                _shouldSetState = true;
                                _model.viewDataTable = [];
                                _model.viewDataTable = _model.searchQueryResult!
                                    .toList()
                                    .cast<SearchQueryRow>();
                              } else if ((String var1) {
                                return var1.length >= 4;
                              }(_model.searchBoxTextController.text)) {
                                _model.completeSearchQueryResult =
                                    await SQLiteManager.instance.searchQuery(
                                  columnName: () {
                                    if (_model.radioButtonValue ==
                                        'Vehicle Number') {
                                      return 'F_ONLY_VNO';
                                    } else if (_model.radioButtonValue ==
                                        'Hirer Name') {
                                      return 'F_HRR_NAME';
                                    } else if (_model.radioButtonValue ==
                                        'Mobile') {
                                      return 'F_MOBILE';
                                    } else {
                                      return 'F_ONLY_VNO';
                                    }
                                  }(),
                                  limitCount: 999999999,
                                  searchVal:
                                      _model.searchBoxTextController.text,
                                );
                                _shouldSetState = true;
                                _model.viewDataTable = [];
                                _model.viewDataTable = _model
                                    .completeSearchQueryResult!
                                    .toList()
                                    .cast<SearchQueryRow>();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Invalid input',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF12151C),
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Search records...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF12151C),
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE0E0E0),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: _model
                                    .searchBoxTextController!.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _model.searchBoxTextController?.clear();
                                      var _shouldSetState = false;
                                      if (_model.searchBoxTextController.text
                                              .length ==
                                          0) {
                                        _model.initialSearchQueryResult =
                                            await SQLiteManager.instance
                                                .searchQuery(
                                          columnName: () {
                                            if (_model.radioButtonValue ==
                                                'Vehicle Number') {
                                              return 'F_ONLY_VNO';
                                            } else if (_model
                                                    .radioButtonValue ==
                                                'Hirer Name') {
                                              return 'F_HRR_NAME';
                                            } else if (_model
                                                    .radioButtonValue ==
                                                'Mobile') {
                                              return 'F_MOBILE';
                                            } else {
                                              return 'F_ONLY_VNO';
                                            }
                                          }(),
                                          limitCount: 999999999,
                                          searchVal: '',
                                        );
                                        _shouldSetState = true;
                                        _model.viewDataTable = [];
                                        _model.viewDataTable = _model
                                            .initialSearchQueryResult!
                                            .toList()
                                            .cast<SearchQueryRow>();
                                      } else if (_model.searchBoxTextController
                                                  .text.length >
                                              0 &&
                                          _model.searchBoxTextController.text
                                                  .length <
                                              4) {
                                        _model.searchQueryResult =
                                            await SQLiteManager.instance
                                                .searchQuery(
                                          columnName: () {
                                            if (_model.radioButtonValue ==
                                                'Vehicle Number') {
                                              return 'F_ONLY_VNO';
                                            } else if (_model
                                                    .radioButtonValue ==
                                                'Hirer Name') {
                                              return 'F_HRR_NAME';
                                            } else if (_model
                                                    .radioButtonValue ==
                                                'Mobile') {
                                              return 'F_MOBILE';
                                            } else {
                                              return 'F_ONLY_VNO';
                                            }
                                          }(),
                                          limitCount: 999999999,
                                          searchVal: _model
                                              .searchBoxTextController.text,
                                        );
                                        _shouldSetState = true;
                                        _model.viewDataTable = [];
                                        _model.viewDataTable = _model
                                            .searchQueryResult!
                                            .toList()
                                            .cast<SearchQueryRow>();
                                      } else if ((String var1) {
                                        return var1.length >= 4;
                                      }(_model.searchBoxTextController.text)) {
                                        _model.completeSearchQueryResult =
                                            await SQLiteManager.instance
                                                .searchQuery(
                                          columnName: () {
                                            if (_model.radioButtonValue ==
                                                'Vehicle Number') {
                                              return 'F_ONLY_VNO';
                                            } else if (_model
                                                    .radioButtonValue ==
                                                'Hirer Name') {
                                              return 'F_HRR_NAME';
                                            } else if (_model
                                                    .radioButtonValue ==
                                                'Mobile') {
                                              return 'F_MOBILE';
                                            } else {
                                              return 'F_ONLY_VNO';
                                            }
                                          }(),
                                          limitCount: 999999999,
                                          searchVal: _model
                                              .searchBoxTextController.text,
                                        );
                                        _shouldSetState = true;
                                        _model.viewDataTable = [];
                                        _model.viewDataTable = _model
                                            .completeSearchQueryResult!
                                            .toList()
                                            .cast<SearchQueryRow>();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Invalid input',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }

                                      if (_shouldSetState) safeSetState(() {});
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20,
                                    ),
                                  )
                                : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF12151C),
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          minLines: 1,
                          validator: _model.searchBoxTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Builder(
                          builder: (context) {
                            final paymentTable = _model.viewDataTable.toList();
                            if (paymentTable.isEmpty) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: NoDataComponentWidget(),
                              );
                            }
                            return FlutterFlowDataTable<SearchQueryRow>(
                              controller: _model.paginatedDataTableController,
                              data: paymentTable,
                              columnsBuilder: (onSortChanged) => [
                                DataColumn2(
                                  label: DefaultTextStyle.merge(
                                    softWrap: true,
                                    child: Text(
                                      'Agr No',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                DataColumn2(
                                  label: DefaultTextStyle.merge(
                                    softWrap: true,
                                    child: Text(
                                      'Reg No',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                DataColumn2(
                                  label: DefaultTextStyle.merge(
                                    softWrap: true,
                                    child: Text(
                                      'Hirrer Name',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                DataColumn2(
                                  label: DefaultTextStyle.merge(
                                    softWrap: true,
                                    child: Text(
                                      'Mobile No',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                DataColumn2(
                                  label: DefaultTextStyle.merge(
                                    softWrap: true,
                                    child: Text(
                                      'Vehicle Name',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                              dataRowBuilder: (paymentTableItem,
                                      paymentTableIndex,
                                      selected,
                                      onSelectChanged) =>
                                  DataRow(
                                color: MaterialStateProperty.all(
                                  paymentTableIndex % 2 == 0
                                      ? FlutterFlowTheme.of(context)
                                          .secondaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                ),
                                cells: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.agreementHeaders = await SQLiteManager.instance.headerQuery(
                                        compId: paymentTableItem.fCompId,
                                        contNo: paymentTableItem.fContNo,
                                      );
                                      _model.agreementDetails = await SQLiteManager.instance.detailsQuery(
                                        compId: paymentTableItem.fCompId,
                                        contNo: paymentTableItem.fContNo,
                                      );
                                      if (_model.agreementHeaders!.length > 0) {
                                        context.pushNamed(
                                          'RecordData',
                                          queryParameters: {
                                            'compId': serializeParam(
                                              paymentTableItem.fCompId,
                                              ParamType.int,
                                            ),
                                            'contNo': serializeParam(
                                              paymentTableItem.fContNo,
                                              ParamType.String,
                                            ),
                                            'agrHeaders': serializeParam(
                                              _model.agreementHeaders?.first,
                                              ParamType.SqliteRow,
                                            ),
                                            'agreementDetails': serializeParam(
                                              _model.agreementDetails,
                                              ParamType.SqliteRow,
                                              isList: true,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'No data found for contract : ${paymentTableItem.fContNo}',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).primaryText,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                          ),
                                        );
                                      }
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        (String var1, String var2) {
                                          return (var2?.toString() ?? "") +
                                              "-" +
                                              (var1?.toString() ?? "");
                                        }(
                                            valueOrDefault<String>(
                                              paymentTableItem.fContNo,
                                              '\"\"',
                                            ),
                                            valueOrDefault<String>(
                                              paymentTableItem.fCompId
                                                  .toString(),
                                              '\"\"',
                                            )),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 10,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    (String var1) {
                                      return var1 != null && var1.isNotEmpty
                                          ? var1.toString()
                                          : "";
                                    }(paymentTableItem.fRegsno),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    (String var1) {
                                      return var1 != null && var1.isNotEmpty
                                          ? var1.toString()
                                          : "";
                                    }(paymentTableItem.fHrrName),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    (String var1) {
                                      return var1 != null &&
                                              var1.isNotEmpty &&
                                              var1 != "0"
                                          ? var1.toString()
                                          : "";
                                    }(paymentTableItem.fMobile.toString()),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    (String var1) {
                                      return var1 != null && var1.isNotEmpty
                                          ? var1.toString()
                                          : "";
                                    }(paymentTableItem.fVhcName),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 10,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ].map((c) => DataCell(c)).toList(),
                              ),
                              paginated: true,
                              selectable: false,
                              hidePaginator: false,
                              showFirstLastButtons: false,
                              width: MediaQuery.sizeOf(context).width * 1.3,
                              headingRowHeight: 56,
                              dataRowHeight: 30,
                              columnSpacing: 10,
                              headingRowColor:
                                  FlutterFlowTheme.of(context).tableHeader,
                              borderRadius: BorderRadius.circular(10),
                              addHorizontalDivider: true,
                              addTopAndBottomDivider: false,
                              hideDefaultHorizontalDivider: false,
                              horizontalDividerColor:
                                  FlutterFlowTheme.of(context).accent4,
                              horizontalDividerThickness: 1,
                              addVerticalDivider: true,
                              verticalDividerColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              verticalDividerThickness: 1,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ].divide(SizedBox(height: 16)).around(SizedBox(height: 16)),
          ),
        ),
      ),
    );
  }
}
