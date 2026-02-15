import 'package:backend_project/views/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {


  TextEditingController emailcontroller = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50 ,
      body: Padding(
        padding: const EdgeInsets.only(top: 180 , left: 30 , right: 30),
        child: Column(
          children: [

            Text("Karyana" ,style: GoogleFonts.montserrat(
                color: Color(0xffE31A21),
                fontSize: 40,
                fontWeight: FontWeight.w700
            ),textAlign: TextAlign.center,),

            SizedBox(height: 15,),
            Text("Reset Password" ,style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w500
            ),textAlign: TextAlign.center,),


            SizedBox(height: 30,),

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 60,
                color: Colors.white,
                child: TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            isloading ? Center(child: CircularProgressIndicator(),):

            Container(
              width: 180,
              height: 50,
              child: ElevatedButton(onPressed: ()async{

                try{
                  isloading = true;
                  setState(() {

                  });
                  await authservices()
                      .resetpassword(
                    emailcontroller.text.toString(),
                  )
                      .then((val)
                  {
                    isloading = false;
                    setState(() {

                    });
                    showDialog(context: context, builder: (BuildContext context)
                    {
                      return AlertDialog(
                        content: Text("link send successfully"),
                        actions: [
                          TextButton(onPressed: (){}, child: Text("okay"))
                        ],
                      );
                    }
                    );
                  }
                  );
                }
                catch(e)
                {

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

                  child: Text("Send Reset link",style: GoogleFonts.poppins(
                      color: Color(0xffFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),)),
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                }, child: Text("back to Login",style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Color(0xffE31A21),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xffE31A21),
                ),
                ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}
