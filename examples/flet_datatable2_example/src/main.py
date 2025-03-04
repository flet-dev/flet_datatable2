import logging

import flet as ft
from data import desserts

from flet_datatable2 import DataColumn2, DataRow2, DataTable2, Size

logging.basicConfig(level=logging.DEBUG)


def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    def select_row(e):
        e.control.selected = not e.control.selected
        e.control.update()

    def sort_column(e):
        dt.sort_column_index = e.column_index
        dt.sort_ascending = e.ascending
        sorted_desserts = sorted(
            desserts,
            key=lambda d: getattr(d, e.control.label.value.lower()),
            reverse=not dt.sort_ascending,
        )
        dt.rows = get_data_rows(sorted_desserts)
        dt.update()

    def get_data_columns():
        data_columns = [
            DataColumn2(
                size=Size.L,
                label=ft.Text("Name"),
                on_sort=sort_column,
                heading_row_alignment=ft.MainAxisAlignment.START,
            ),
            DataColumn2(
                ft.Text("Calories"),
                on_sort=sort_column,
                numeric=True,
                heading_row_alignment=ft.MainAxisAlignment.END,
            ),
            DataColumn2(
                ft.Text("Fat"),
                on_sort=sort_column,
                numeric=True,
            ),
            DataColumn2(
                ft.Text("Carbs"),
                on_sort=sort_column,
                numeric=True,
            ),
            DataColumn2(
                ft.Text("Protein"),
                on_sort=sort_column,
                numeric=True,
            ),
            DataColumn2(
                label=ft.Text("Sodium"),
                on_sort=sort_column,
                numeric=True,
            ),
            DataColumn2(
                ft.Text("Calcium"),
                on_sort=sort_column,
                numeric=True,
            ),
            DataColumn2(
                ft.Text("Iron"),
                on_sort=sort_column,
                numeric=True,
            ),
        ]
        return data_columns

    def get_data_rows(desserts):
        data_rows = []
        for dessert in desserts:
            data_rows.append(
                DataRow2(
                    specific_row_height=50,
                    on_select_changed=select_row,
                    cells=[
                        ft.DataCell(content=ft.Text(dessert.name)),
                        ft.DataCell(content=ft.Text(dessert.calories)),
                        ft.DataCell(content=ft.Text(dessert.fat)),
                        ft.DataCell(content=ft.Text(dessert.carbs)),
                        ft.DataCell(content=ft.Text(dessert.protein)),
                        ft.DataCell(content=ft.Text(dessert.sodium)),
                        ft.DataCell(content=ft.Text(dessert.calcium)),
                        ft.DataCell(content=ft.Text(dessert.iron)),
                    ],
                )
            )
        return data_rows

    page.add(
        dt := DataTable2(
            show_checkbox_column=True,
            expand=True,
            column_spacing=0,
            heading_row_color=ft.Colors.SECONDARY_CONTAINER,
            horizontal_margin=12,
            sort_ascending=True,
            bottom_margin=10,
            min_width=600,
            columns=get_data_columns(),
            rows=get_data_rows(desserts),
        ),
    )


ft.app(main)
