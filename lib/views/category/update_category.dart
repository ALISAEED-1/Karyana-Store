import 'package:backend_project/models/category.dart';
import 'package:backend_project/services/category_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateCategory extends StatefulWidget {
  final CategoryModel model;
  const UpdateCategory({super.key, required this.model});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();

  bool isloading = false;

  @override
  void initState() {
    super.initState();

    namecontroller = TextEditingController(
        text: widget.model.categoryname.toString()
    );
    imagecontroller = TextEditingController(
        text: widget.model.image.toString()
    );

  }

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
        padding: const EdgeInsets.only(right: 30, left: 30, top: 150),
        child: Column(
          children: [
            Text("Update Category", style: GoogleFonts.poppins(
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
                  isloading = true;
                  setState(() {

                  });

                  await CategoryServices()
                      .updateCategory(CategoryModel(
                      docId: widget.model.docId.toString(),
                      categoryname: namecontroller.text.toString(),
                      image: imagecontroller.text.toString(),
                      createdAt: DateTime.now().millisecondsSinceEpoch

                  )).then((value){
                    isloading = false;
                    setState(() {

                    });
                    showDialog(context: context, builder: (BuildContext context)
                    {
                      return AlertDialog(
                        content: Text("update successfully "),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, child: Text("okay"))
                        ],
                      );
                    });
                  }
                  );
                                }
                                catch (e){
                  isloading = false;
                  setState(() {

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

                  child: Text("update task",style: GoogleFonts.poppins(
                      color: Color(0xffFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),)),
                )
          ],
        ),
      ),
    );
  }
}
