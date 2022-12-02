import 'package:velocity_x/velocity_x.dart';

import 'package:docpad/models/cart.dart';
import 'package:docpad/models/catalog.dart';

class MyStore extends VxStore {
  CatalogModel? catalog;
  CartModel? cart;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart!.catalog = catalog!;
  }
}
