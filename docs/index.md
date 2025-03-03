# Introduction

DataTable2 Control for Flet based on [DataTable2 package](https://pub.dev/packages/data_table_2) for Flutter. 

DataTable2 features fixed/sticky header/top rows and left columns and many other useful features additionally to all the properties of built-in Flet [DataTable](https://flet.dev/docs/controls/datatable).

## Installation

## Examples

[Live example](https://flet-controls-gallery.fly.dev/layout/datatable2)

### DataTable2 with `empty` property and no data rows

```
import flet as ft
from flet_datatable2 import DataColumn2, DataTable2

def main(page: ft.Page):
    page.add(
        DataTable2(
            columns=[
                DataColumn2(ft.Text("First name")),
                DataColumn2(ft.Text("Last name")),
                DataColumn2(ft.Text("Age"), numeric=True),
            ],
            empty=ft.Text("This table is empty."),
        ),
    )


ft.app(main)
```

### DataTable2 with fixed heading row and sorting

<img src="assets/datatable2-example.gif">

See source code for this example [here](https://github.com/flet-dev/flet_datatable2/tree/main/examples/flet_datatable2_example/src).

## Classes

[DataTable2](/docs/datatable2.md)

[DataColumn2](/docs/datacolumn2.md)

[DataRow2](/docs/datarow2.md)


