import 'package:backend_project/models/product.dart';
import 'package:backend_project/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoriteProducts extends StatefulWidget {
  final String userId;  // You MUST pass your userId here

  const FavoriteProducts({super.key, required this.userId});

  @override
  State<FavoriteProducts> createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade50 ,
         title: Text(
          "Karyana",
          style: GoogleFonts.montserrat(
            color: const Color(0xffE31A21),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Favorite Products",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

        Expanded(
          child: StreamProvider<List<ProductModel>>(
            create: (_) => ProductServices().getFavorite(widget.userId),
            initialData: const [],
            child: Consumer<List<ProductModel>>(
              builder: (context, productList, child) {

                // EMPTY STATE
                if (productList.isEmpty) {
                  return Center(
                    child: Text(
                      "No Favorite Products ",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Color(0xffE31A21),
                      ),
                    ),
                  );
                }

                // LIST OF FAVORITES
                return ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                product.image.toString(),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image,
                                    size: 80, color: Colors.red),
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [
                                      Text(
                                        product.name.toString(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          product.favorite != null &&
                                              product.favorite!.contains(widget.userId)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                        onPressed: () async {
                                          // If currently favorite → remove
                                          if (product.favorite!.contains(widget.userId)) {
                                            await ProductServices().removefromfavorite(
                                              userId: widget.userId,
                                              ProductId: product.docId!,
                                            );
                                          }
                                          // If not favorite → add
                                          else {
                                            await ProductServices().addtofavorite(
                                              userId: widget.userId,
                                              ProductId: product.docId!,
                                            );
                                          }
                                        },
                                      ),

                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  Row(
                                    children: [
                                      // PRICE + DISCOUNT
                                      if (product.discountprize != null) ...[
                                        Text(
                                          '\$${product.prize}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '\$${(product.prize! - product.discountprize!).toStringAsFixed(2)}',
                                          style: GoogleFonts.poppins(
                                            color: Color(0xffE31A21),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ] else
                                        Text(
                                          '\$${product.prize}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),

                                      const SizedBox(width: 17),

                                      // STOCK
                                      Container(
                                        width: 90,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 7),
                                          child: Text(
                                            'Stock: ${product.stock}',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
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
                  },
                );
              },
            ),
          ),

        ),
        ],
        ),
      ),
    );
  }
}
