// ------ pages import ------
import 'cartScreen.dart';

// ------ UI -------
import '../config/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// splash
import 'package:flutter_native_splash/flutter_native_splash.dart';

// food
import '../models/food.dart';
import '../models/menu.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final int kebabLimit = 99;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _widgetAppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            for (int i = 0; i < Menu.allFood.length; i++) kebabItem(i),
            const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Dodadkowe informacje:\nDostępne są sosy - Edem (Łagodny), Wąż (Mieszany), Płonący krzew (pikantny)',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ))
          ],
        ),
      ),
    );
  }

  //
  // WIDGET FUNCIONS
  //

  Widget kebabItem(int index) {
    Food food = Menu.allFood[index];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: mainColor,
                width: 3,
              )),
          child: SizedBox(
            height: 120,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        food.imgPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                            Text(food.description.toString()),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("${food.price}PLN"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(top: 5, right: 0, child: _foodControls(index))
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _foodControls(int index) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                child: const Align(alignment: Alignment.topCenter, child: Icon(Icons.remove)),
                onTap: () {
                  if (Menu.customerCart[index] != 0) {
                    setState(() {
                      Menu.customerCart[index] -= 1;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: Text(
                Menu.customerCart[index].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (Menu.customerCart[index] != kebabLimit) {
                    setState(() {
                      Menu.customerCart[index] += 1;
                    });
                  }
                },
                child: const Align(alignment: Alignment.topCenter, child: Icon(Icons.add)),
              ),
            ),
          ],
        ),
      ),
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
          'MENU',
          textAlign: TextAlign.center,
          style: GoogleFonts.oswald(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  ),
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    size: 50,
                  ),
                ),
                if (Menu.cartItemCount != 0)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      child: Text(
                        Menu.cartItemCount.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
