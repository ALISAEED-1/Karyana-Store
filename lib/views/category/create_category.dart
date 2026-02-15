import 'package:backend_project/models/category.dart';
import 'package:backend_project/services/category_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  bool isloading = false;

  @override
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

            Text("Create Category", style: GoogleFonts.poppins(
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
                    hintText: 'Category Name',
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

            SizedBox(height: 24,),

            isloading ? Center(child: CircularProgressIndicator(),)
                : Container(
             height: 50,
                  child: ElevatedButton(onPressed: ()async{
                                try{

                  setState(() {
                    isloading = true;
                  });

                  await CategoryServices()
                      .createCategory(CategoryModel(
                      categoryname: namecontroller.text.toString(),
                      image: imagecontroller.text.toString(),
                      createdAt: DateTime.now().millisecondsSinceEpoch

                  ))
                      .then((value){


                    setState(() {
                      isloading = false;
                    });

                    showDialog(context: context, builder: (BuildContext context)
                    {
                      return AlertDialog(
                        content: Text("Create Successfully"),
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

                  child: Text("Add Category",style: GoogleFonts.poppins(
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
