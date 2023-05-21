// ------ UI -------
import '../config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kebab/models/food.dart';
import '../models/menu.dart';

import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItemIndexes = Menu.cartItemIndexes;

    return Scaffold(
      appBar: _widgetAppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: DefaultTextStyle(
                style: GoogleFonts.oswald(color: Colors.black, fontWeight: FontWeight.w600),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) => _foodCartItem(cartItemIndexes, index),
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemCount: cartItemIndexes.length),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  const BoxDecoration(color: mainColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: DefaultTextStyle(
                style: GoogleFonts.oswald(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Row(
                        children: [
                          const Text('SUMA: '),
                          Text(Menu.totalCost.toStringAsFixed(2).replaceFirst('.', ','), style: const TextStyle(color: Colors.red)),
                          const Text(' PLN')
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          width: 170,
                          height: 50,
                          decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                              child: Text(
                            'ZŁÓŻ ZAMÓWIENIE',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _foodCartItem(List<int> cartItemIndexes, int index) {
    final Food food = Menu.allFood[cartItemIndexes[index]];

    return Stack(
      children: [
        Row(
          children: [
            Image.asset(
              food.imgPath,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(food.name, style: const TextStyle(fontSize: 20)),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        Positioned(
            right: 5,
            top: 10,
            child: Text(
              "${Menu.customerCart[cartItemIndexes[index]]}x${food.price.toStringAsFixed(2)} PLN",
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  PreferredSize _widgetAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'KOSZYK',
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
