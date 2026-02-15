import 'package:backend_project/models/category.dart';
import 'package:backend_project/services/category_services.dart';
import 'package:backend_project/views/category/create_category.dart';
import 'package:backend_project/views/category/update_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class GetallCategory extends StatefulWidget {
  const GetallCategory({super.key});

  @override
  State<GetallCategory> createState() => _GetallCategoryState();
}

class _GetallCategoryState extends State<GetallCategory> {
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
           Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCategory()));
        },
            backgroundColor: Colors.red.shade50,
            child: Icon(Icons.add,)),

        body: Padding(
          padding: const EdgeInsets.only(right: 30 , left: 30 , top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("All Categories" ,style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              SizedBox(height: 20,),

              Expanded(
                child: StreamProvider.value(
                    value: CategoryServices().getAllCategory(),
                    initialData: [CategoryModel()],
                    builder: (context , child){
                      List<CategoryModel> CategoryList = context .watch<List<CategoryModel>>();
                      return ListView.builder(
                        itemCount: CategoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(25),
                                  child: Image.network(
                                    CategoryList[index].image.toString(),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.broken_image, size: 40, color: Colors.red);
                                    },
                                  ),
                                ),
                                title: Text(CategoryList[index].categoryname.toString()),

                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(onPressed: ()async{
                                      try{
                                        await CategoryServices().deleteCategory(CategoryList[index].docId.toString())
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
                                    }, icon: Icon(Icons.delete)),
                                    IconButton(onPressed: ()async{
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateCategory(model: CategoryList[index])));
                                    }, icon: Icon(Icons.edit)),


                                  ],
                                ),
                              ),

                              SizedBox(height: 10,),
                              Divider(
                                height: 5,
                                thickness: 1,
                                color: Color(0xff000000),
                              ),
                              SizedBox(height: 20,),
                            ],
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
