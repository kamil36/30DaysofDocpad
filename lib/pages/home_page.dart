// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unused_import

import 'package:docpad/core/store.dart';
import 'package:docpad/models/cart.dart';
import 'package:docpad/utils/routes.dart';
import 'package:docpad/utils/widgets/home_widgets/catalog_header.dart';
import 'package:docpad/utils/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:docpad/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String name = "Docpad";
  final String url = "https://fakestoreapi.com/products";

  bool _isLoading = true; // Tracks whether data is being loaded
  String? _errorMessage; // Stores error messages, if any

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final catalogJson = response.body;
        final decodedData = jsonDecode(catalogJson);
        var productsData = decodedData;

        CatalogModel.items = List.from(productsData)
            .map<Item>((item) => Item.fromJson(item)) // Fixed Item.fromJson
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setState(() {
        _isLoading = false; // Loading is complete, whether successful or not
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;

    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.grey[200],
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (ctx, _, user) => FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
          backgroundColor: context.theme.focusColor,
          child: Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ).badge(
          color: Vx.gray200,
          size: 22,
          count: _cart?.items.length ?? 0, // Safe null-check here
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              Expanded(
                child: _isLoading
                    ? CircularProgressIndicator().centered()
                    : _errorMessage != null
                        ? Center(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : CatalogModel.items.isNotEmpty
                            ? CatalogList().py16()
                            : Center(
                                child: Text(
                                  "No products available",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
