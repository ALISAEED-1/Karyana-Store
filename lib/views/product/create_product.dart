import 'package:backend_project/models/category.dart';
import 'package:backend_project/models/product.dart';
import 'package:backend_project/services/category_services.dart';
import 'package:backend_project/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController prizecontroller = TextEditingController();
  TextEditingController disprizecontroller = TextEditingController();
  TextEditingController stockcontroller = TextEditingController();
  bool isloading = false;

  List<CategoryModel> Categorylist = [];
  CategoryModel? _selectedCategory;

  @override
  @override
  void initState() {
    CategoryServices().getCategoryListOnce().then((val){
      Categorylist = val! ;
      setState(() {});
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        leading: Icon(Icons.arrow_back,color: Color(0xffE31A21),),
        title: Text("Karyana", style: GoogleFonts.montserrat(
          color: Color(0xffE31A21),
          fontWeight: FontWeight.w700,
        ),),
        centerTitle: true,
      ),


      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30 ,top: 150),
        child: Column(
          children: [

            Text("Create Product", style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600
            ),textAlign: TextAlign.center,),

            SizedBox(height: 24,),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 350,
                height: 60,
                color: Colors.grey.shade300,
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 350,
                height: 60,
                color: Colors.grey.shade300,
                child: TextField(
                  controller: imagecontroller,
                  decoration: InputDecoration(
                    hintText: 'Paste Image URL',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 350,
                height: 60,
                color: Colors.grey.shade300,
                child: TextField(
                  controller: prizecontroller,
                  decoration: InputDecoration(
                    hintText: 'Product Prize',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 350,
                height: 60,
                color: Colors.grey.shade300,
                child: TextField(
                  controller: disprizecontroller,
                  decoration: InputDecoration(
                    hintText: 'Discount Prize',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 350,
                height: 60,
                color: Colors.grey.shade300,
                child: TextField(
                  controller: stockcontroller,
                  decoration: InputDecoration(
                    hintText: 'Product Stock',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16,),
            Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                // same as ElevatedButton default

              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    items: Categorylist.map((e){
                      return DropdownMenuItem(
                          value: e,
                          child: Text(e.categoryname.toString()));
                    }).toList(),
                    value: _selectedCategory,
                    isExpanded: true,

                    style: GoogleFonts.poppins(
                      color: Color(0xffE31A21),
                      fontWeight: FontWeight.w600,
                    ),

                    hint: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Select Category",style: GoogleFonts.poppins(
                        color: Color(0xffE31A21)
                      ),),
                    ),
                    icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Color(0xffE31A21), size: 28),
                    onChanged: (val){
                      _selectedCategory = val;
                      setState(() {});
                    }),
              ),
            ),

            SizedBox(height: 24,),

            isloading ? Center(child: CircularProgressIndicator(),)
                : Container(
              height: 50,
              child: ElevatedButton(onPressed: ()async{
                try{

                  if (prizecontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Price is mandatory")),
                    );
                    return;
                  }

                  // Parse inputs safely
                  double? prize = double.tryParse(prizecontroller.text);
                  if (prize == null || prize <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Price must be a positive number")),
                    );
                    return;
                  }

                  double? discount;
                  if (disprizecontroller.text.isNotEmpty) {
                    discount = double.tryParse(disprizecontroller.text);
                    if (discount == null || discount <= 0 || discount >= prize) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Discount must be > 0 and < actual price")),
                      );
                      return;
                    }
                  }

                  int? stock;
                  if (stockcontroller.text.isNotEmpty) {
                    stock = int.tryParse(stockcontroller.text);
                    if (stock == null || stock < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Stock must be a positive integer")),
                      );
                      return;
                    }
                  }

                  setState(() {
                    isloading = true;
                  });

                  await ProductServices()
                      .createProduct(ProductModel(
                      name: namecontroller.text.toString(),
                      image: imagecontroller.text.toString(),
                      prize:double.parse(prizecontroller.text),
                      discountprize: double.parse(disprizecontroller.text),
                      stock: int.parse(stockcontroller.text),
                      categoryId: _selectedCategory!.docId,
                      createdAt: DateTime.now().millisecondsSinceEpoch

                  ))
                      .then((value){


                    setState(() {
                      isloading = false;
                    });

                    showDialog(context: context, builder: (BuildContext context)
                    {
                      return AlertDialog(
                        content: Text("Product Create Successfully"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("Okay"))
                        ],
                      );
                    });
                  }
                  );
                }
                catch (e){

                  setState(() {
                    isloading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString()))
                  );
                }

              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )

                  ),

                  child: Text("Add Product",style: GoogleFonts.poppins(
                      color: Color(0xffFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),)
              ),
            )

          ],

        ),
      ),
    );
  }
}
