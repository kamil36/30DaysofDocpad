import 'package:docpad/models/catalog.dart';
import 'package:flutter/material.dart';

import '../utils/widgets/drawer.dart';
import '../utils/widgets/item_widget.dart';

class HomePage extends StatelessWidget {
  final int days = 30;
  final String name = "Docpad";

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(05, (index) => CatalogModel.Items[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: dummyList.length,
          itemBuilder: (context, index) {
            return ItemWidget(
              item: dummyList[index],
            );
          },
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
