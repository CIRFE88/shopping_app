import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/cart_provider.dart';
import 'package:shopping_provider/screens/cart%20screen/cart_screen.dart';
import 'package:shopping_provider/screens/favorite%20screen/favorite_screen.dart';
import 'package:shopping_provider/screens/home%20screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Size size = Size.zero;
  int currentIndex = 0;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> _buildScreens = [
    HomeScreen(),
    FavortieScreen(),
    CartScreen(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.black26,
          width: 0.5,
        ))),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            bottomNavigationBarTheme:
                Theme.of(context).bottomNavigationBarTheme,
          ),
          child: BottomNavigationBar(
            items: [
              getIcon(0, "Home", Iconsax.home_14),
              getIcon(1, "Favourite", Iconsax.heart),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(
                    bottom: size.height * 0.005,
                  ),
                  margin: EdgeInsets.only(bottom: 2),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Icon(
                            Iconsax.bag,
                            color: Colors.black26,
                            size: 22,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -3,
                        child: context
                                .watch<CartProvider>()
                                .shoppingCart
                                .isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                radius: 10,
                                child: Text(
                                  context
                                      .watch<CartProvider>()
                                      .shoppingCart
                                      .length
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      )
                    ],
                  ),
                ),
                label: "Cart",
              ),
              getIcon(3, "Orders", CupertinoIcons.list_bullet_indent),
              getIcon(4, "Profile", Iconsax.profile_circle4),
            ],
            currentIndex: currentIndex,
            onTap: (int tab) {
              setState(() {
                currentIndex = tab;
              });
            },
          ),
        ),
      ),
    );
  }

  getIcon(int i, String label, IconData icon) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(
          bottom: size.height * 0.001,
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
