import 'food.dart';

class Menu {
  static final List<Food> allFood = [
    Food(imgPath: 'assets/images/kebab.png', name: 'Księga Rodzaju', description: 'No po prostu był kebab', price: 420.0),
    Food(imgPath: 'assets/images/kebab.png', name: 'Dawid', description: 'Mała bułka', price: 18.99),
    Food(imgPath: 'assets/images/kebab.png', name: 'Goliat', description: 'Bułka gigant', price: 21.99),
    Food(imgPath: 'assets/images/rollo.png', name: 'Małe rollo', description: 'Rollo dla dzieci', price: 16.99),
    Food(imgPath: 'assets/images/rollo.png', name: 'Duże rollo', description: 'Rollo dla istot poza ziemskich', price: 19.99),
    Food(imgPath: 'assets/images/rollo.png', name: 'Judasz', description: 'Rollo special - 2 sosy', price: 25.99),
    Food(imgPath: 'assets/images/k_box.png', name: 'Stajenka', description: 'Mały box', price: 17.99),
    Food(imgPath: 'assets/images/k_box.png', name: 'Arka przymierza', description: 'Mega box', price: 23.99),
    Food(
        imgPath: 'assets/images/k_box.png',
        name: 'Ostatnia Wieczerza',
        description: 'Zestaw familijny\nDuży kabab, kubeczek frytek i 4 napoje',
        price: 90.99),
    Food(imgPath: 'assets/images/rollo.png', name: 'Wieża Babel', description: 'Metrowe Rollo Kebab', price: 79.99),
    Food(imgPath: 'assets/images/kebab.png', name: 'Arka Noego', description: 'Kebab Mix mięs', price: 25.99),
    Food(imgPath: 'assets/images/k_stick.jpg', name: 'Włócznia przeznaczenia', description: 'Kebab na patyku', price: 14.99),
    Food(imgPath: 'assets/images/frytki.png', name: 'Małe frytki', description: '', price: 8.99),
    Food(imgPath: 'assets/images/frytki.png', name: 'Duże frytki', description: '', price: 11.99),
    Food(imgPath: 'assets/images/water.png', name: 'Woda naturalna', description: 'bul bul', price: 4.99),
    Food(imgPath: 'assets/images/sp_water.png', name: 'Woda gazowana', description: 'bul bul', price: 4.99),
    Food(imgPath: 'assets/images/cola.png', name: 'Coca-cola', description: 'Środek do przeczyszczania rur', price: 7.99),
    Food(imgPath: 'assets/images/fanta.png', name: 'Fanta', description: 'Pomańcza w płynie', price: 7.99),
  ];

  // private struct containing number of food in Cart
  static List<int>? _customerCart;

  // just a wrapper
  static List<int> get customerCart => _customerCart ??= List.filled(Menu.allFood.length, 0);

  // indexes of food in cart (no. at least 1)
  static List<int> get cartItemIndexes => customerCart.asMap().entries.where((entry) => entry.value != 0).map((entry) => entry.key).toList();

  // total sum of item count in cart
  static int get cartItemCount => customerCart.reduce((a, b) => a + b);

  // totals sum of items in cart
  static double get totalCost => customerCart
      .asMap()
      .map((index, count) => MapEntry(index, count * Menu.allFood[index].price))
      .values
      .fold(0.0, (sum, element) => sum + element);
}
