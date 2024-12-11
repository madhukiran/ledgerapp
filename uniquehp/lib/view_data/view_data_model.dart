import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'view_data_widget.dart' show ViewDataWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewDataModel extends FlutterFlowModel<ViewDataWidget> {
  ///  Local state fields for this page.

  List<SearchQueryRow> viewDataTable = [];
  void addToViewDataTable(SearchQueryRow item) => viewDataTable.add(item);
  void removeFromViewDataTable(SearchQueryRow item) =>
      viewDataTable.remove(item);
  void removeAtIndexFromViewDataTable(int index) =>
      viewDataTable.removeAt(index);
  void insertAtIndexInViewDataTable(int index, SearchQueryRow item) =>
      viewDataTable.insert(index, item);
  void updateViewDataTableAtIndex(
          int index, Function(SearchQueryRow) updateFn) =>
      viewDataTable[index] = updateFn(viewDataTable[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (Search Query)] action in ViewData widget.
  List<SearchQueryRow>? initialSearchQueryResultCopy;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // Stores action output result for [Backend Call - SQLite (Search Query)] action in RadioButton widget.
  List<SearchQueryRow>? radioIInitialSearchQuery;
  // State field(s) for SearchBox widget.
  FocusNode? searchBoxFocusNode;
  TextEditingController? searchBoxTextController;
  String? Function(BuildContext, String?)? searchBoxTextControllerValidator;
  // Stores action output result for [Backend Call - SQLite (Search Query)] action in SearchBox widget.
  List<SearchQueryRow>? initialSearchQueryResult;
  // Stores action output result for [Backend Call - SQLite (Search Query)] action in SearchBox widget.
  List<SearchQueryRow>? searchQueryResult;
  // Stores action output result for [Backend Call - SQLite (Search Query)] action in SearchBox widget.
  List<SearchQueryRow>? completeSearchQueryResult;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<SearchQueryRow>();
  // Stores action output result for [Backend Call - SQLite (HeaderQuery)] action in Container widget.
  List<HeaderQueryRow>? agreementHeaders;
  // Stores action output result for [Backend Call - SQLite (DetailsQuery)] action in Container widget.
  List<DetailsQueryRow>? agreementDetails;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchBoxFocusNode?.dispose();
    searchBoxTextController?.dispose();

    paginatedDataTableController.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
