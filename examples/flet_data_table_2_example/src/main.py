import flet as ft

from flet_data_table_2 import FletDataTable2


def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    page.add(
        ft.Container(
            expand=True,
            padding=20,
            content=FletDataTable2(
                column_spacing=0,
                expand=True,
                tooltip="My new FletDataTable2 Control tooltip",
                value="My new FletDataTable2 Flet Control",
            ),
        )
    )


ft.app(main)
