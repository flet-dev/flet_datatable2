import 'package:flet/flet.dart';

import 'flet_data_table_2.dart';

CreateControlFactory createControl = (CreateControlArgs args) {
  switch (args.control.type) {
    case "fletdatatable2":
      return FletDataTable2Control(
          key: args.key,
          parent: args.parent,
          control: args.control,
          children: args.children,
          parentDisabled: args.parentDisabled,
          backend: args.backend);
    default:
      return null;
  }
};

void ensureInitialized() {
  // nothing to initialize
}
