import json
from enum import Enum
from typing import Any, Optional

from flet.core.control import Control, OptionalNumber
from flet.core.control_event import ControlEvent
from flet.core.event_handler import EventHandler
from flet.core.types import MainAxisAlignment, OptionalEventCallable


class Size(Enum):
    """Relative size of a column determines the share of total table width allocated to each individual column.

    When determining column widths, ratios between `S`, `M` and `L` columns are kept (i.e. Large columns are set to 1.2x width of Medium ones).
    See `DataTable2.smRatio`, `DataTable2.lmRatio`. Default S/M ratio is 0.67, L/M ratio is 1.2.
    """

    S = "s"
    M = "m"
    L = "l"


class DataColumnSortEvent(ControlEvent):
    def __init__(self, e: ControlEvent):
        super().__init__(e.target, e.name, e.data, e.control, e.page)
        d = json.loads(e.data)
        self.column_index: int = d.get("i")
        self.ascending: bool = d.get("a")


class DataColumn2(Control):
    """Column configuration for a [DataTable2](/datatable2).

    One column configuration must be provided for each column to display in the table.

    Additional to Flet [DataColumn](https://flet.dev/docs/controls/datatable/#datacolumn), adds the capability to set relative column size via size property.

    """

    def __init__(
        self,
        label: Control,
        size: Optional[Size] = None,
        numeric: Optional[bool] = None,
        tooltip: Optional[str] = None,
        fixed_width: OptionalNumber = None,
        heading_row_alignment: Optional[MainAxisAlignment] = None,
        on_sort: OptionalEventCallable[DataColumnSortEvent] = None,
        #
        # Control
        #
        ref=None,
        visible: Optional[bool] = None,
        disabled: Optional[bool] = None,
        data: Any = None,
    ):
        Control.__init__(self, ref=ref, visible=visible, disabled=disabled, data=data)

        self.__on_sort = EventHandler(lambda e: DataColumnSortEvent(e))
        self._add_event_handler("sort", self.__on_sort.get_handler())

        self.label = label
        self.size = size
        self.fixed_width = fixed_width
        self.numeric = numeric
        self.tooltip = tooltip
        self.heading_row_alignment = heading_row_alignment
        self.on_sort = on_sort

    def _get_control_name(self):
        return "datacolumn2"

    def _get_children(self):
        self.__label._set_attr_internal("n", "label")
        return [self.__label]

    def before_update(self):
        super().before_update()
        assert self.__label.visible, "label must be visible"

    # label
    @property
    def label(self) -> Control:
        """
        See DataColumn [label](https://flet.dev/docs/controls/datatable#label).
        """
        return self.__label

    @label.setter
    def label(self, value: Control):
        self.__label = value

    # size
    @property
    def size(self) -> Optional[Size]:
        """
        **NEW**

        Column sizes are determined based on available width by distributing it to individual columns accounting for their relative sizes.

        Value is of type `Size` and defaults to `Size.S`.
        """
        return self.__size

    @size.setter
    def size(self, value: Optional[Size]):
        self.__size = value
        self._set_enum_attr("size", value, Size)

    # numeric
    @property
    def numeric(self) -> bool:
        """
        See DataColumn [numeric](https://flet.dev/docs/controls/datatable#numeric).
        """

        return self._get_attr("numeric", data_type="bool", def_value=False)

    @numeric.setter
    def numeric(self, value: Optional[bool]):
        self._set_attr("numeric", value)

    # fixed_width
    @property
    def fixed_width(self) -> OptionalNumber:
        """
        **NEW**

        Defines absolute width of the column in pixel (as opposed to relative `size` used by default).
        """
        return self._get_attr("fixedWidth")

    @fixed_width.setter
    def fixed_width(self, value: OptionalNumber):
        self._set_attr("fixedWidth", value)

    # tooltip
    @property
    def tooltip(self) -> Optional[str]:
        """
        See DataColumn [tooltip](https://flet.dev/docs/controls/datatable#tooltip).
        """
        return self._get_attr("tooltip")

    @tooltip.setter
    def tooltip(self, value: Optional[str]):
        self._set_attr("tooltip", value)

    # heading_row_alignment
    @property
    def heading_row_alignment(self) -> Optional[MainAxisAlignment]:
        """
        See DataColumn [heading_row_alignment](https://flet.dev/docs/controls/datatable#heading_row_alignment).
        """
        return self.__heading_row_alignment

    @heading_row_alignment.setter
    def heading_row_alignment(self, value: Optional[MainAxisAlignment]):
        self.__heading_row_alignment = value
        self._set_enum_attr("headingRowAlignment", value, MainAxisAlignment)

    # on_sort
    @property
    def on_sort(self) -> OptionalEventCallable["DataColumnSortEvent"]:
        """
        See DataColumn [on_sort](https://flet.dev/docs/controls/datatable#on_sort).
        """
        return self.__on_sort.handler

    @on_sort.setter
    def on_sort(self, handler: OptionalEventCallable["DataColumnSortEvent"]):
        self.__on_sort.handler = handler
        self._set_attr("onSort", True if handler is not None else None)
