// ignore_for_file: deprecated_member_use

import 'package:docpad/models/catalog.dart';
import 'package:docpad/utils/widgets/home_widgets/add_to_cart.dart';
import 'package:docpad/utils/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  Item catalog;

  HomeDetailPage({Key? key, required this.catalog, Key? Key})
      : assert(catalog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${catalog.price}".text.bold.xl4.red800.make(),
            AddToCart(
              catalog: catalog,
            ).wh(120, 50)
          ],
        ).p32(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.asset(catalog.image),
            ).h32(context),
            Expanded(
                child: VxArc(
              height: 30.0,
              arcType: VxArcType.CONVEY,
              edge: VxEdge.TOP,
              child: Container(
                color: context.cardColor,
                width: context.screenWidth,
                child: Column(
                  children: [
                    catalog.name.text.xl4
                        .color(context.accentColor)
                        .bold
                        .make(),
                    catalog.desc.text.textStyle(context.captionStyle).xl.make(),
                    10.heightBox,
                    "Ipsum nonumy est takimata et elitr. Amet eos eirmod aliquyam sed amet dolor sed amet et, est aliquyam lorem sit erat sed consetetur, diam et ipsum labore dolores nonumy, et dolor kasd et sit ipsum eirmod vero lorem, voluptua tempor accusam nonumy consetetur labore diam dolore magna. Ipsum eos dolores."
                        .text
                        .textStyle(context.captionStyle)
                        .make()
                        .p16()
                  ],
                ).py64(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
