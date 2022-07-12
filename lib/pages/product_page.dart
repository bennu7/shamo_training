import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/cart_page.dart';
import 'package:shamo/pages/detail_chat_page.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/product_provider.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/theme.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product';

  final ProductModel product;

  const ProductPage({Key? key, required this.product}) : super(key: key);
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // final List images = [
  //   1,
  //   2,
  //   3,
  //   4,
  //   5,
  // ];
  // final List familiarShoes = [
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  //   'assets/image_shoes.png',
  // ];

  // inisialisasi nilai awal slider untuk CarouselSlider
  int currentIndex = 0;
  //untuk button wishlist
  // bool isWishlist = false;

  @override
  Widget build(BuildContext context) {
    // ProductProvider productPhoto = Provider.of<ProductProvider>(context);
    // // print(productPhoto.productPhotos);
    // print("REBUILD");

    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    //* untuk showDialog tipe nya Future yang harus menggunakan async await
    Future<void> showSuccessDialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width - (2 * defaultMargin),
              child: AlertDialog(
                backgroundColor: backgroundColor3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: primaryTextColor,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icon_success.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Hurray :)",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Item added successfully",
                        style: secondaryTextStyle,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 154,
                        height: 44,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, CartPage.routeName);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "View My Chart",
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
        ),
      );
    }

    Widget familiarShoesCard(String imageUrl) {
      return Container(
        width: 54,
        height: 54,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }

    Widget header() {
      // set nilai awal untuk indicator -1 => karena awal" nilai bernilai 0 sebelum di mulai mapping
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_bag,
                    color: backgroundColor1,
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: widget.product.galleries!
                .map(
                  (image) => Image.network(
                    image.url.toString(),
                    width: MediaQuery.of(context).size.width,
                    height: 310,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
                initialPage: 0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries!.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          )
        ],
      );
    }

    Widget content() {
      int index = -1;

      return Container(
        margin: const EdgeInsets.only(top: 17),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            //* NOTE: Header
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name.toString(),
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.product.category!.name.toString(),
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Image.asset(
                      (wishlistProvider.isWishlist(widget.product) == true)
                          ? 'assets/button_wishlist_blue.png'
                          : 'assets/button_wishlit.png',
                      width: 46,
                    ),
                    onTap: () {
                      // setState(() {
                      //   isWishlist = !isWishlist;
                      // });
                      wishlistProvider.setProduct(widget.product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: SizedBox(
                            height: 15,
                            child: Text(
                              (wishlistProvider.isWishlist(widget.product) ==
                                      true)
                                  ? "Has been added to the Wishlist"
                                  : "Has been removed from the Wishlist",
                              style: primaryTextStyle.copyWith(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                          backgroundColor:
                              (wishlistProvider.isWishlist(widget.product) ==
                                      true)
                                  ? secondaryColor
                                  : alertColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // *NOTE: PRICE
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: backgroundColor2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price starts from",
                    style: primaryTextStyle,
                  ),
                  Text(
                    "\$${widget.product.price}",
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            // *NOTE:DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product.description.toString(),
                    style: subtitleTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            // *NOTE: FAMILIAR SHOES
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Text(
                      "Familiar Shoes",
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // gunakan mapping ini laternatif dari listviewbuilder
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.product.galleries!.map((image) {
                        index++;
                        return Container(
                            margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                            ),
                            child: familiarShoesCard(image.url.toString()));
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            // *NOTE:BUTTONS
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, DetailChatPage.routes);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailChatPage(
                            product: widget.product,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/button_chat.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: TextButton(
                        onPressed: () {
                          cartProvider.addCart(widget.product);
                          showSuccessDialog();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Add To Cart",
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
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

    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
