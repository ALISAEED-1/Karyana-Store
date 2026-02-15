import 'package:backend_project/models/product.dart';
import 'package:backend_project/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'favorite_products.dart';

class GetproductbyCategoryid extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final String userId;

  const GetproductbyCategoryid({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.userId,
  });

  @override
  State<GetproductbyCategoryid> createState() => _GetproductbyCategoryidState();
}

class _GetproductbyCategoryidState extends State<GetproductbyCategoryid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        // leading: Icon(Icons.arrow_back, color: Color(0xffE31A21)),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back, color: Color(0xffE31A21)) ),
        title: Text(
          widget.categoryName,
          style: GoogleFonts.montserrat(
            color: const Color(0xffE31A21),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.categoryName} Products",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: StreamProvider.value(
                value: ProductServices()
                    .getProductsByCategoryId(widget.categoryId),
                initialData: [ProductModel()],
                builder: (context, child) {
                  List<ProductModel> productList =
                  context.watch<List<ProductModel>>();

                  if (productList.isEmpty ||
                      (productList.length == 1 &&
                          productList[0].docId == null)) {
                    return const Center(
                      child: Text(
                        "No products in this category",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60,top: 10, left: 5,right: 5),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];

                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 6,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // TAG
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Bulk Order",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // IMAGE
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  product.image??"",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // NAME
                            Text(
                              product.name??"",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            // PRICE
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${product.prize} Rs",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () async {
                                    final userId = widget.userId;
                                    final isFavorite = product.favorite?.contains(userId) ?? false;

                                    if (isFavorite) {
                                      await ProductServices().removefromfavorite(
                                        userId: userId,
                                        ProductId: product.docId ?? "",
                                      );
                                    } else {
                                      await ProductServices().addtofavorite(
                                        userId: userId,
                                        ProductId: product.docId ?? "",
                                      );
                                    }

                                    // Update UI immediately

                                  },
                                  icon: Icon(
                                    (product.favorite?.contains(widget.userId) ?? false)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                                )


                              ],
                            ),

                            // DISCOUNT PRICE
                            if (product.discountprize!= null && product.discountprize ! > 0 )
                              Text(
                                "${product.discountprize ?? ""} Rs",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),


                            const SizedBox(height: 5),

                            // BUY BUTTON + CART
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}
