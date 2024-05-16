import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/cart_provider.dart';
import 'package:shopping_provider/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Cart",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Consumer<CartProvider>(
                                builder: (context, value, child) {
                                  return Column(
                                    children: value.shoppingCart
                                        .map((cartItem) =>
                                            CartItem(cartItem: cartItem))
                                        .toList(),
                                  );
                                },
                              )
                            ],
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: size.height * 0.25),
                                Icon(
                                  Iconsax.bag,
                                  size: size.width * 0.20,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: size.height * 0.20),
                                Text(
                                  "Your cart is empty!",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.20),
              SizedBox(
                child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Info",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.040,
                            ),
                          ),
                          SizedBox(height: size.height * 0.010),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total",
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                "\$${context.watch<CartProvider>().cartSubTotal}",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.008),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shipping Fee",
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                "\$${context.watch<CartProvider>().shippingCharge}",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                "\$${context.watch<CartProvider>().cartTotal}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.030),
                          Container(
                            width: size.width,
                            height: size.height * 0.065,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Checkout (\$${context.watch<CartProvider>().cartTotal})",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
