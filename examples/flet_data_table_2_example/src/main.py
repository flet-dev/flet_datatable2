import logging

import flet as ft
from data import desserts

from flet_data_table_2 import DataColumn2, DataRow2, FletDataTable2

logging.basicConfig(level=logging.DEBUG)


def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    def get_data_columns():
        data_columns = [
            DataColumn2(ft.Text("Name")),
            DataColumn2(ft.Text("Calories")),
            DataColumn2(ft.Text("Fat")),
            DataColumn2(ft.Text("Carbs")),
            DataColumn2(ft.Text("Protein")),
            DataColumn2(ft.Text("Sodium")),
            DataColumn2(ft.Text("Calcium")),
            DataColumn2(ft.Text("Iron")),
        ]
        return data_columns

    def get_data_rows():
        data_rows = []
        for dessert in desserts:
            data_rows.append(
                DataRow2(
                    cells=[
                        ft.DataCell(content=ft.Text(dessert.name)),
                        ft.DataCell(content=ft.Text(dessert.calories)),
                        ft.DataCell(content=ft.Text(dessert.fat)),
                        ft.DataCell(content=ft.Text(dessert.carbs)),
                        ft.DataCell(content=ft.Text(dessert.protein)),
                        ft.DataCell(content=ft.Text(dessert.sodium)),
                        ft.DataCell(content=ft.Text(dessert.calcium)),
                        ft.DataCell(content=ft.Text(dessert.iron)),
                    ]
                )
            )
        return data_rows

    page.add(
        FletDataTable2(
            expand=True,
            columns=get_data_columns(),
            rows=get_data_rows(),
        ),
    )


ft.app(main)
