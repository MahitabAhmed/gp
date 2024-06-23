import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:philo_task/models/product.dart';
import 'package:philo_task/presentation/widgets/custom_cart_buttom.dart';
import 'package:philo_task/presentation/widgets/custom_favourite_icon_button.dart';
import 'package:philo_task/presentation/widgets/custom_image.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> allProducts;
  final bool inFavScreen;
  final int index;
  final double raduis;

  const ProductItem(
      {Key? key,
      this.raduis = 20,
      required this.index,
      required this.product,
      required this.allProducts,
      required this.inFavScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, productDetailsScreen, arguments: {
        //   'product': product,
        //   'index': index,
        // });
      },
      child: Container(
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis),
          color: Colors.grey,
        ),
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      tileMode: TileMode.mirror,
                      colors: [
                        Color(0xFFcdacf9),
                        Color(0xFF4568dc),
                        // Color(0xFF4568dc),
                        //Color(0xFFb06ab3),
                      ]),
                )),
            SizedBox(
              child: CustomImage(
                product.image!,
                radius: raduis,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: CustomFavouriteIconButton(product: product, index: index),
            // ),
            // Positioned(
            //   top: 10,
            //   left: 10,
            //   child:
            //       CustomCartButton(product: product, allProducts: allProducts),
            // ),
            Positioned(
              bottom: 12,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/tag-dollar.svg",
                        width: 17,
                        height: 17,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        product.price!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
