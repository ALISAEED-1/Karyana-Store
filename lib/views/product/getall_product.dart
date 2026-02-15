import 'package:backend_project/models/product.dart';
import 'package:backend_project/services/product_services.dart';
import 'package:backend_project/views/product/create_product.dart';
import 'package:backend_project/views/product/update_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class GetallProduct extends StatefulWidget {
  const GetallProduct({super.key});

  @override
  State<GetallProduct> createState() => _GetallProductState();
}

class _GetallProductState extends State<GetallProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade50 ,
            title: Text("Karyana", style: GoogleFonts.montserrat(
            color: Color(0xffE31A21),
            fontWeight: FontWeight.w700,
          ),),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),



        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProduct()));
        },
            backgroundColor: Colors.red.shade50,
            child: Icon(Icons.add)),

        body: Padding(
          padding: const EdgeInsets.only(right: 30 , left: 30 , top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("All Products" ,style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              SizedBox(height: 20,),

              Expanded(
                child: StreamProvider.value(
                    value: ProductServices().getAllProduct(),
                    initialData: [ProductModel()],
                    builder: (context , child){
                      List<ProductModel> ProductList = context .watch<List<ProductModel>>();
                      return ListView.builder(
                        itemCount: ProductList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: 300,

                              padding: const EdgeInsets.all(12), // spacing inside
                              decoration: BoxDecoration(
                                color: Colors.white, // background
                                borderRadius: BorderRadius.circular(25), // rounded corners
                                border: Border.all( // border side
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                boxShadow: [ // shadow
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ClipRRect(

                                    borderRadius: BorderRadiusGeometry.circular(5),
                                    child: Image.network(
                                      ProductList[index].image.toString(),
                                      width: 56,
                                      height: 56,

                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.broken_image,size: 50, color: Colors.red);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(

                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(ProductList[index].name.toString(),style: GoogleFonts.poppins(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),),
                                        ],
                                      ),
                                       SizedBox(height: 20,),
                                      Row(
                                        children: [
                                          if (ProductList[index].discountprize != null ) ...[
                                            Text(
                                              '\$${ProductList[index].prize}',
                                              style: TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '\$${(ProductList[index].prize! - ProductList[index].discountprize!).toStringAsFixed(2)}',                                            style: GoogleFonts.poppins(
                                                color: Color(0xffE31A21),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ] else
                                            Text(
                                              '\$${ProductList[index].prize}',
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),

                                          SizedBox(width: 10,),
                                          // Stock display
                                          Container(
                                            width: 90,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.black, // background
                                              borderRadius: BorderRadius.circular(20), // rounded corners
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 7),
                                              child: Text(
                                                'Stock: ${ProductList[index].stock}',
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

                                  Spacer(),
                                  Column(
                                    children: [
                                      IconButton(onPressed: ()async{
                                        try{
                                          await ProductServices().deleteProduct(ProductList[index].docId.toString())
                                              .then((val){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("deleted succesfully"))
                                            );
                                          }
                                          );
                                        }
                                        catch(e){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(e.toString()))
                                          );
                                        }
                                      }, icon: Icon(Icons.delete,size: 20,)),


                                      IconButton(onPressed: ()async{
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProduct(model: ProductList[index])));
                                      }, icon: Icon(Icons.edit,size: 20,)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },

                      );
                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}

