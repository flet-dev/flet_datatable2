//library;

import 'package:data_table_2/data_table_2.dart';
import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

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
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        smRatio: 0.75,
        lmRatio: 1.5,
        columns: const [
          DataColumn2(
            size: ColumnSize.S,
            label: Text('Column A'),
          ),
          DataColumn(
            label: Text('Column B'),
          ),
          DataColumn(
            label: Text('Column C'),
          ),
          DataColumn(
            label: Text('Column D'),
          ),
          DataColumn2(
            label: Text('Column NUMBERS'),
            numeric: true,
            size: ColumnSize.L,
          ),
        ],
        rows: List<DataRow>.generate(
            100,
            (index) => DataRow(cells: [
                  DataCell(Text('A' * (10 - index % 10))),
                  DataCell(Text('B' * (10 - (index + 5) % 10))),
                  DataCell(Text('C' * (15 - (index + 5) % 10))),
                  DataCell(Text('D' * (15 - (index + 10) % 10))),
                  DataCell(Text(((index + 0.1) * 25.4).toString()))
                ])));

    return constrainedControl(
        context, datatable, widget.parent, widget.control);
  }
}
