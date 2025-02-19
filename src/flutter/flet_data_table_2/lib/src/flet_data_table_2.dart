//library;

import 'package:data_table_2/data_table_2.dart';
import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

import 'data_sources.dart';

class FletDataTable2Control extends StatefulWidget {
  final Control? parent;
  final Control control;
  //final List<Control> children;
  //final bool parentDisabled;
  //final FletControlBackend backend;

  const FletDataTable2Control({
    super.key,
    this.parent,
    required this.control,
    //required this.children,
    //required this.parentDisabled,
    //required this.backend
  });

  @override
  State<FletDataTable2Control> createState() => _FletDataTable2ControlState();
}

class _FletDataTable2ControlState extends State<FletDataTable2Control>
    with FletStoreMixin {
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late DessertDataSource _dessertsDataSource;
  bool _initialized = false;
  final ScrollController _controller = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _dessertsDataSource = DessertDataSource(context);
      _initialized = true;
      _dessertsDataSource.addListener(() {
        setState(() {});
      });
    }
  }

  void _sort<T>(
    Comparable<T> Function(Dessert d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertsDataSource.dispose();
    _controller.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("DataTableControl build: ${widget.control.id}");

    // bool tableDisabled = widget.control.isDisabled || widget.parentDisabled;

    // var datatable =
    //     withControls(widget.children.where((c) => c.isVisible).map((c) => c.id),
    //         (content, viewModel) {
    //   var bgColor = widget.control.attrString("bgColor");
    //   var border = parseBorder(Theme.of(context), widget.control, "border");
    //   var borderRadius = parseBorderRadius(widget.control, "borderRadius");
    //   var gradient =
    //       parseGradient(Theme.of(context), widget.control, "gradient");
    //   var horizontalLines =
    //       parseBorderSide(Theme.of(context), widget.control, "horizontalLines");
    //   var verticalLines =
    //       parseBorderSide(Theme.of(context), widget.control, "verticalLines");
    //   var defaultDecoration =
    //       Theme.of(context).dataTableTheme.decoration ?? const BoxDecoration();

    //   BoxDecoration? decoration;
    //   if (bgColor != null ||
    //       border != null ||
    //       borderRadius != null ||
    //       gradient != null) {
    //     decoration = (defaultDecoration as BoxDecoration).copyWith(
    //         color: parseColor(Theme.of(context), bgColor),
    //         border: border,
    //         borderRadius: borderRadius,
    //         gradient: gradient);
    //   }

    //   TableBorder? tableBorder;
    //   if (horizontalLines != null || verticalLines != null) {
    //     tableBorder = TableBorder(
    //         horizontalInside: horizontalLines ?? BorderSide.none,
    //         verticalInside: verticalLines ?? BorderSide.none);
    //   }

    //   Clip clipBehavior =
    //       parseClip(widget.control.attrString("clipBehavior"), Clip.none)!;

    var datatable = DataTable2(
        scrollController: _controller,
        horizontalScrollController: _horizontalController,
        columnSpacing: 0,
        horizontalMargin: 12,
        bottomMargin: 10,
        minWidth: 600,
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        onSelectAll: (val) =>
            setState(() => _dessertsDataSource.selectAll(val)),
        columns: [
          DataColumn2(
            label: const Text('Desert'),
            size: ColumnSize.S,
            onSort: (columnIndex, ascending) =>
                _sort<String>((d) => d.name, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Calories'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.calories, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Fat (gm)'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.fat, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Carbs (gm)'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.carbs, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Protein (gm)'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.protein, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Sodium (mg)'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.sodium, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Calcium (%)'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.calcium, columnIndex, ascending),
          ),
          DataColumn2(
            label: const Text('Iron (%)'),
            size: ColumnSize.S,
            numeric: true,
            onSort: (columnIndex, ascending) =>
                _sort<num>((d) => d.iron, columnIndex, ascending),
          ),
        ],
        rows: List<DataRow>.generate(_dessertsDataSource.rowCount,
            (index) => _dessertsDataSource.getRow(index)));

    return constrainedControl(
        context, datatable, widget.parent, widget.control);
  }
}
