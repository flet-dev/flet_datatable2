from enum import Enum
from typing import Any, Optional, Union

from flet.core.constrained_control import ConstrainedControl
from flet.core.control import OptionalNumber


class FletDataTable2(ConstrainedControl):
    """
    FletDataTable2 Control.
    """

    def __init__(
        self,
        #
        # Control
        #
        opacity: OptionalNumber = None,
        tooltip: Optional[str] = None,
        visible: Optional[bool] = None,
        data: Any = None,
        #
        # ConstrainedControl
        #
        left: OptionalNumber = None,
        top: OptionalNumber = None,
        right: OptionalNumber = None,
        bottom: OptionalNumber = None,
        expand: Union[None, bool, int] = None,
        #
        # FletDataTable2 specific
        #
        value: Optional[str] = None,
        column_spacing: OptionalNumber = None,
    ):
        ConstrainedControl.__init__(
            self,
            tooltip=tooltip,
            opacity=opacity,
            visible=visible,
            data=data,
            left=left,
            top=top,
            right=right,
            bottom=bottom,
            expand=expand,
        )

        self.value = value
        self.column_spacing = column_spacing

    def _get_control_name(self):
        return "flet_data_table_2"

    # value
    @property
    def value(self):
        return self._get_attr("value")

    @value.setter
    def value(self, value):
        self._set_attr("value", value)

    # column_spacing
    @property
    def column_spacing(self) -> OptionalNumber:
        return self._get_attr("columnSpacing")

    @column_spacing.setter
    def column_spacing(self, value: OptionalNumber):
        self._set_attr("columnSpacing", value)
