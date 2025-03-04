import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flet/flet.dart' as ft;
import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

class DataTable2Control extends StatefulWidget {
  final Control? parent;
  final Control control;
  final List<Control> children;
  final bool parentDisabled;
  final FletControlBackend backend;

  const DataTable2Control(
      {super.key,
      this.parent,
      required this.control,
      required this.children,
      required this.parentDisabled,
      required this.backend});

  @override
  State<DataTable2Control> createState() => _DataTable2ControlState();
}

class _DataTable2ControlState extends State<DataTable2Control>
    with FletStoreMixin {
  //final ScrollController _horizontalController = ScrollController();
  //final ScrollController _controller = ScrollController();

  // @override
  // void dispose() {
  //   _horizontalController.dispose();
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint("DataTableControl build: ${widget.control.id}");

    bool tableDisabled = widget.control.isDisabled || widget.parentDisabled;

    ColumnSize? parseSize(String? size, [ColumnSize? defValue]) {
      if (size == null) {
        return defValue;
      }
      return ColumnSize.values.firstWhereOrNull(
              (e) => e.name.toLowerCase() == size.toLowerCase()) ??
          defValue;
    }

    var datatable =
        withControls(widget.children.where((c) => c.isVisible).map((c) => c.id),
            (content, viewModel) {
      var emptyCtrls =
          widget.children.where((c) => c.name == "empty" && c.isVisible);
      Widget? empty = emptyCtrls.isNotEmpty
          ? createControl(
              widget.control, emptyCtrls.first.id, widget.control.isDisabled)
          : null;
      IconData? sortArrowIcon =
          parseIcon(widget.control.attrString("sortArrowIcon"));
      var bgColor = widget.control.attrString("bgColor");
      var border = parseBorder(Theme.of(context), widget.control, "border");
      var borderRadius = parseBorderRadius(widget.control, "borderRadius");
      var gradient =
          parseGradient(Theme.of(context), widget.control, "gradient");
      var horizontalLines =
          parseBorderSide(Theme.of(context), widget.control, "horizontalLines");
      var verticalLines =
          parseBorderSide(Theme.of(context), widget.control, "verticalLines");
      var defaultDecoration =
          Theme.of(context).dataTableTheme.decoration ?? const BoxDecoration();
      var checkboxAlignment = parseAlignment(
          widget.control, "checkboxAlignment", Alignment.center)!;

      BoxDecoration? decoration;
      if (bgColor != null ||
          border != null ||
          borderRadius != null ||
          gradient != null) {
        decoration = (defaultDecoration as BoxDecoration).copyWith(
            color: parseColor(Theme.of(context), bgColor),
            border: border,
            borderRadius: borderRadius,
            gradient: gradient);
      }

      TableBorder? tableBorder;
      if (horizontalLines != null || verticalLines != null) {
        tableBorder = TableBorder(
            horizontalInside: horizontalLines ?? BorderSide.none,
            verticalInside: verticalLines ?? BorderSide.none);
      }

      Clip clipBehavior =
          parseClip(widget.control.attrString("clipBehavior"), Clip.none)!;

      return withPageArgs((context, pageArgs) {
        return DataTable2(
            bottomMargin: widget.control.attrDouble("bottomMargin"),
            minWidth: widget.control.attrDouble("minWidth"),
            //horizontalScrollController: _horizontalController,
            //scrollController: _controller,
            decoration: decoration,
            border: tableBorder,
            empty: empty,
            isHorizontalScrollBarVisible:
                widget.control.attrBool("isHorizontalScrollBarVisible"),
            isVerticalScrollBarVisible:
                widget.control.attrBool("isVerticalScrollBarVisible"),
            fixedLeftColumns: widget.control.attrInt("fixedLeftColumns") ?? 0,
            fixedTopRows: widget.control.attrInt("fixedTopRows") ?? 1,
            fixedColumnsColor:
                widget.control.attrColor("fixedColumnsColor", context),
            fixedCornerColor:
                widget.control.attrColor("fixedCornerColor", context),
            smRatio: widget.control.attrDouble("smRatio") ?? 0.67,
            lmRatio: widget.control.attrDouble("lmRatio") ?? 1.2,
            clipBehavior: clipBehavior,
            sortArrowIcon: sortArrowIcon ?? Icons.arrow_upward,
            sortArrowAnimationDuration:
                parseDuration(widget.control, "sortArrowAnimationDuration") ??
                    Duration(microseconds: 150),
            checkboxHorizontalMargin:
                widget.control.attrDouble("checkboxHorizontalMargin"),
            checkboxAlignment: checkboxAlignment,
            headingCheckboxTheme: parseCheckboxTheme(
                Theme.of(context),
                widget.control.attrString("headingCheckboxTheme") != null
                    ? json.decode(
                        widget.control.attrString("headingCheckboxTheme")!)
                    : null),
            datarowCheckboxTheme: parseCheckboxTheme(
                Theme.of(context),
                widget.control.attrString("dataRowCheckboxTheme") != null
                    ? json.decode(
                        widget.control.attrString("dataRowCheckboxTheme")!)
                    : null),
            showHeadingCheckBox:
                widget.control.attrBool("showHeadingCheckbox", true)!,
            columnSpacing: widget.control.attrDouble("columnSpacing"),
            dataRowColor: parseWidgetStateColor(
                Theme.of(context), widget.control, "dataRowColor"),
            dataRowHeight: widget.control.attrDouble("dataRowHeight"),
            //dataRowMinHeight: widget.control.attrDouble("dataRowMinHeight"),
            //dataRowMaxHeight: widget.control.attrDouble("dataRowMaxHeight"),
            dataTextStyle: parseTextStyle(
                Theme.of(context), widget.control, "dataTextStyle"),
            headingRowColor: parseWidgetStateColor(
                Theme.of(context), widget.control, "headingRowColor"),
            headingRowHeight: widget.control.attrDouble("headingRowHeight"),
            headingTextStyle: parseTextStyle(
                Theme.of(context), widget.control, "headingTextStyle"),
            headingRowDecoration: parseBoxDecoration(Theme.of(context),
                widget.control, "headingRowDecoration", pageArgs),
            dividerThickness: widget.control.attrDouble("dividerThickness"),
            horizontalMargin: widget.control.attrDouble("horizontalMargin"),
            showBottomBorder:
                widget.control.attrBool("showBottomBorder", false)!,
            showCheckboxColumn:
                widget.control.attrBool("showCheckboxColumn", false)!,
            sortAscending: widget.control.attrBool("sortAscending", false)!,
            sortColumnIndex: widget.control.attrInt("sortColumnIndex"),
            onSelectAll: widget.control.attrBool("onSelectAll", false)!
                ? (selected) {
                    widget.backend.triggerControlEvent(
                        widget.control.id,
                        "select_all",
                        selected != null ? selected.toString() : "");
                  }
                : null,
            columns: viewModel.controlViews
                .where((c) =>
                    c.control.type == "datacolumn2" && c.control.isVisible)
                .map((column) {
              var labelCtrls = column.children
                  .where((c) => c.name == "label" && c.isVisible);
              return DataColumn2(
                  //size: ColumnSize.S,
                  size: parseSize(
                      column.control.attrString("size"), ColumnSize.S)!,
                  fixedWidth: column.control.attrDouble("fixedWidth"),
                  numeric: column.control.attrBool("numeric", false)!,
                  tooltip: column.control.attrString("tooltip"),
                  headingRowAlignment: parseMainAxisAlignment(
                      column.control.attrString("headingRowAlignment")),
                  //mouseCursor: WidgetStateMouseCursor.clickable,
                  onSort: column.control.attrBool("onSort", false)!
                      ? (columnIndex, ascending) {
                          widget.backend.triggerControlEvent(
                              column.control.id,
                              "sort",
                              json.encode({"i": columnIndex, "a": ascending}));
                        }
                      : null,
                  label: ft.createControl(column.control, labelCtrls.first.id,
                      column.control.isDisabled || tableDisabled));
            }).toList(),
            rows: viewModel.controlViews
                .where((c) => c.control.type == "datarow2" && c.control.isVisible)
                .map((row) {
              return DataRow2(
                  key: ValueKey(row.control.id),
                  selected: row.control.attrBool("selected", false)!,
                  color: parseWidgetStateColor(
                      Theme.of(context), row.control, "color"),
                  specificRowHeight:
                      row.control.attrDouble("specificRowHeight"),
                  decoration: parseBoxDecoration(
                      Theme.of(context), row.control, "decoration", pageArgs),
                  onSelectChanged:
                      row.control.attrBool("onSelectChanged", false)!
                          ? (selected) {
                              widget.backend.triggerControlEvent(
                                  row.control.id,
                                  "select_changed",
                                  selected != null ? selected.toString() : "");
                            }
                          : null,
                  onLongPress: row.control.attrBool("onLongPress", false)!
                      ? () {
                          widget.backend.triggerControlEvent(
                              row.control.id, "long_press");
                        }
                      : null,
                  onDoubleTap: row.control.attrBool("onDoubleTap", false)!
                      ? () {
                          widget.backend.triggerControlEvent(
                              row.control.id, "double_tap");
                        }
                      : null,
                  onTap: row.control.attrBool("onTap", false)!
                      ? () {
                          widget.backend
                              .triggerControlEvent(row.control.id, "tap");
                        }
                      : null,
                  onSecondaryTap: row.control.attrBool("onSecondaryTap", false)!
                      ? () {
                          widget.backend.triggerControlEvent(
                              row.control.id, "secondary_tap");
                        }
                      : null,
                  onSecondaryTapDown:
                      row.control.attrBool("onSecondaryTapDown", false)!
                          ? (details) {
                              widget.backend.triggerControlEvent(
                                  row.control.id, "secondary_tap_down");
                            }
                          : null,
                  cells: row.children
                      .where((c) => c.type == "datacell" && c.isVisible)
                      .map((cell) => DataCell(
                            ft.createControl(row.control, cell.childIds.first,
                                row.control.isDisabled || tableDisabled),
                            placeholder: cell.attrBool("placeholder", false)!,
                            showEditIcon: cell.attrBool("showEditIcon", false)!,
                            onDoubleTap: cell.attrBool("onDoubleTap", false)!
                                ? () {
                                    widget.backend.triggerControlEvent(
                                        cell.id, "double_tap");
                                  }
                                : null,
                            onLongPress: cell.attrBool("onLongPress", false)!
                                ? () {
                                    widget.backend.triggerControlEvent(
                                        cell.id, "long_press");
                                  }
                                : null,
                            onTap: cell.attrBool("onTap", false)!
                                ? () {
                                    widget.backend
                                        .triggerControlEvent(cell.id, "tap");
                                  }
                                : null,
                            onTapCancel: cell.attrBool("onTapCancel", false)!
                                ? () {
                                    widget.backend.triggerControlEvent(
                                        cell.id, "tap_cancel");
                                  }
                                : null,
                            onTapDown: cell.attrBool("onTapDown", false)!
                                ? (details) {
                                    widget.backend.triggerControlEvent(
                                        cell.id,
                                        "tap_down",
                                        json.encode({
                                          "kind": details.kind?.name,
                                          "lx": details.localPosition.dx,
                                          "ly": details.localPosition.dy,
                                          "gx": details.globalPosition.dx,
                                          "gy": details.globalPosition.dy,
                                        }));
                                  }
                                : null,
                          ))
                      .toList());
            }).toList());
      });
    });

    return constrainedControl(
        context, datatable, widget.parent, widget.control);
  }
}
