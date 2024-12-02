// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unused_import

import 'package:docpad/core/store.dart';
import 'package:docpad/models/cart.dart';
import 'package:docpad/utils/routes.dart';
import 'package:docpad/utils/widgets/home_widgets/catalog_header.dart';
import 'package:docpad/utils/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:docpad/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Docpad";

  final url = "https://api.jsonbin.io/v3/b/639348c2c5b3a64f1bc77b00";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");

    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;

    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.cardColor,
        floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (ctx, _, user) => FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
            backgroundColor: context.theme.buttonColor,
            child: Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(
              color: Vx.gray200,
              size: 22,
              count: _cart!.items.length,
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().py16().expand(),
              ],
            ),
          ),
        ));
  }
}
