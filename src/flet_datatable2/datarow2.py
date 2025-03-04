from typing import Any, List, Optional

from flet.core.box import BoxDecoration
from flet.core.control import Control, OptionalNumber
from flet.core.datatable import DataCell
from flet.core.types import ColorValue, ControlStateValue, OptionalControlEventCallable


class DataRow2(Control):
    """
    Extension of [DataRow](https://flet.dev/docs/controls/datatable#datarow).

    Adds row level `tap` events. There are also `onSecondaryTap` and `onSecondaryTapDown` which are not available in DataCells and which can be useful in Desktop settings when a reaction to the right click is required.
    """

    def __init__(
        self,
        cells: List[DataCell],
        color: ControlStateValue[ColorValue] = None,
        decoration: Optional[BoxDecoration] = None,
        specific_row_height: OptionalNumber = None,
        selected: Optional[bool] = None,
        on_long_press: OptionalControlEventCallable = None,
        on_select_changed: OptionalControlEventCallable = None,
        on_double_tap: OptionalControlEventCallable = None,
        on_secondary_tap: OptionalControlEventCallable = None,
        on_secondary_tap_down: OptionalControlEventCallable = None,
        on_tap: OptionalControlEventCallable = None,
        #
        # Control
        #
        ref=None,
        visible: Optional[bool] = None,
        disabled: Optional[bool] = None,
        data: Any = None,
    ):
        Control.__init__(self, ref=ref, visible=visible, disabled=disabled, data=data)

        self.cells = cells
        self.color = color
        self.decoration = decoration
        self.specific_row_height = specific_row_height
        self.selected = selected
        self.on_long_press = on_long_press
        self.on_select_changed = on_select_changed
        self.on_double_tap = on_double_tap
        self.on_secondary_tap = on_secondary_tap
        self.on_secondary_tap_down = on_secondary_tap_down
        self.on_tap = on_tap

    def _get_control_name(self):
        return "datarow2"

    def __contains__(self, item):
        return item in self.__cells

    def before_update(self):
        super().before_update()
        assert any(
            cell.visible for cell in self.__cells
        ), "cells must contain at minimum one visible DataCell"
        self._set_attr_json("color", self.__color, wrap_attr_dict=True)
        self._set_attr_json("decoration", self.__decoration)

    def _get_children(self):
        return self.__cells

    # cells
    @property
    def cells(self) -> List[DataCell]:
        """
        See DataRow [cells](https://flet.dev/docs/controls/datatable#cells).
        """
        return self.__cells

    @cells.setter
    def cells(self, value: List[DataCell]):
        # assert all(
        #     isinstance(cell, DataCell) for cell in value
        # ), "cells must contain only DataCell instances"
        self.__cells = value

    # color
    @property
    def color(self) -> ControlStateValue[str]:
        """
        See DataRow [color](https://flet.dev/docs/controls/datatable#color).
        """
        return self.__color

    @color.setter
    def color(self, value: ControlStateValue[str]):
        self.__color = value

    # decoration
    @property
    def decoration(self) -> Optional[BoxDecoration]:
        """
        **NEW**

        Decoration to be applied to the given row. Value is an instance of [BoxDecoration](https://flet.dev/docs/reference/types/boxdecoration).
        When applied, it `divider_thickness` won't take effect.
        """
        return self.__decoration

    @decoration.setter
    def decoration(self, value: Optional[BoxDecoration]):
        self.__decoration = value

    # specific_row_height
    @property
    def specific_row_height(self) -> OptionalNumber:
        """
        **NEW**

        Specific row height. If not provided, `data_row_height` will be applied.
        """
        return self._get_attr("specificRowHeight")

    @specific_row_height.setter
    def specific_row_height(self, value: OptionalNumber):
        self._set_attr("specificRowHeight", value)

    # selected
    @property
    def selected(self) -> bool:
        """
        See DataRow [selected](https://flet.dev/docs/controls/datatable#selected).
        """
        return self._get_attr("selected", data_type="bool", def_value=False)

    @selected.setter
    def selected(self, value: Optional[bool]):
        self._set_attr("selected", value)

    # on_long_press
    @property
    def on_long_press(self) -> OptionalControlEventCallable:
        """
        See DataRow [on_long_press](https://flet.dev/docs/controls/datatable#on_long_press).
        """
        return self._get_event_handler("long_press")

    @on_long_press.setter
    def on_long_press(self, handler: OptionalControlEventCallable):
        self._add_event_handler("long_press", handler)
        self._set_attr("onLongPress", True if handler is not None else None)

    # on_tap
    @property
    def on_tap(self) -> OptionalControlEventCallable:
        """
        **NEW**

        Row tap handler. Won't be called if tapped cell has `tap` event handler.
        """
        return self._get_event_handler("tap")

    @on_tap.setter
    def on_tap(self, handler: OptionalControlEventCallable):
        self._add_event_handler("tap", handler)
        self._set_attr("onTap", True if handler is not None else None)

    # on_double_tap
    @property
    def on_double_tap(self) -> OptionalControlEventCallable:
        """
        **NEW**

        Row double tap handler. Won't be called if tapped cell has `tap` event handler.
        """
        return self._get_event_handler("double_tap")

    @on_double_tap.setter
    def on_double_tap(self, handler: OptionalControlEventCallable):
        self._add_event_handler("double_tap", handler)
        self._set_attr("onDoubleTap", True if handler is not None else None)

    # on_secondary_tap
    @property
    def on_secondary_tap(self) -> OptionalControlEventCallable:
        """
        **NEW**

        Row right click handler. Won't be called if tapped cell has `tap` event.
        """
        return self._get_event_handler("secondary_tap")

    @on_secondary_tap.setter
    def on_secondary_tap(self, handler: OptionalControlEventCallable):
        self._add_event_handler("secondary_tap", handler)
        self._set_attr("onSecondaryTap", True if handler is not None else None)

    # on_secondary_tap_down
    @property
    def on_secondary_tap_down(self) -> OptionalControlEventCallable:
        """
        **NEW**

        Row right mouse down handler. Won't be called if tapped cell has `tap` event handler.
        """
        return self._get_event_handler("secondary_tap_down")

    @on_secondary_tap_down.setter
    def on_secondary_tap_down(self, handler: OptionalControlEventCallable):
        self._add_event_handler("secondary_tap_down", handler)
        self._set_attr("onSecondaryTapDown", True if handler is not None else None)

    # on_select_changed
    @property
    def on_select_changed(self) -> OptionalControlEventCallable:
        """
        See DataRow [on_select_changed](https://flet.dev/docs/controls/datatable#on_select_changed).
        """
        return self._get_event_handler("select_changed")

    @on_select_changed.setter
    def on_select_changed(self, handler: OptionalControlEventCallable):
        self._add_event_handler("select_changed", handler)
        self._set_attr("onSelectChanged", True if handler is not None else None)
