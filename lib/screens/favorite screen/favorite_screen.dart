import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/models/product_model.dart';
import 'package:shopping_provider/provider/product_provider.dart';

class FavortieScreen extends StatefulWidget {
  const FavortieScreen({super.key});

  @override
  State<FavortieScreen> createState() => _FavortieScreenState();
}

class _FavortieScreenState extends State<FavortieScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final List<ProductModel> allProducts = [
      ...productProvider.shirts,
      ...productProvider.pants,
      ...productProvider.shoes,
    ];

    final List<ProductModel> favoriteProducts =
        allProducts.where((product) => product.isFavorite).toList();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Favorites Products",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.050,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.020),
              SizedBox(
                width: size.width,
                child: TextFormField(
                  decoration: InputDecoration(
                    focusColor: Colors.black38,
                    isCollapsed: false,
                    hintText: "Search products",
                    prefixIcon: Icon(Icons.search),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.01,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black26, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black26, width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.030),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white54,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white60,
                            spreadRadius: 0.5,
                            offset: Offset(5, 5)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          width: 90,
                          height: 90,
                        ),
                        SizedBox(height: size.height * 0.020),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.name,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.033,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${product.price}",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.040,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  productProvider.toggleFavorite(product);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.07),
                                  radius: 18,
                                  child: Icon(
                                    CupertinoIcons.delete_solid,
                                    color: Colors.redAccent,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}