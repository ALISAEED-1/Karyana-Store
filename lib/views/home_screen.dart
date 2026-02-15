import 'package:backend_project/models/category.dart';
import 'package:backend_project/models/product.dart';
import 'package:backend_project/services/category_services.dart';
import 'package:backend_project/services/product_services.dart';
import 'package:backend_project/views/product/getProductbyId.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.red.shade50 ,
        title: Text("Karyana", style: GoogleFonts.montserrat(
          color: Color(0xffE31A21),
          fontWeight: FontWeight.w700,
        ),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Icon(Icons.shopping_cart_outlined,color: Color(0xffE31A21) ,size: 40,)
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all( 20),
        child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: const Icon(Icons.cancel_rounded, color: Colors.grey),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                ),
              ),
            ),

            SizedBox(height: 20,),
            SizedBox(
              height: 80,
              child: StreamBuilder<List<CategoryModel>>(
                stream: CategoryServices().getAllCategory(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final categories = snapshot.data!;

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    separatorBuilder: (_, __) => const SizedBox(width: 30),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GetproductbyCategoryid(
                                categoryId: cat.docId!,
                                categoryName: cat.categoryname!,
                                userId: widget.userId,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                cat.image ?? "",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 40,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              cat.categoryname ?? "",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(
              height: 4,
              color: Color(0xff2124491A),
            ),

            SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: ProductServices().getAllProduct(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data!;

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60,top: 10, left: 5,right: 5),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

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
            ),

          ],
        ),
      ),
    );
  }
}
