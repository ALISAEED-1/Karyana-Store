import 'package:backend_project/models/users.dart';
import 'package:backend_project/provider/user_provider.dart';
import 'package:backend_project/services/user_services.dart';
import 'package:backend_project/views/profile.dart';
import 'package:backend_project/views/register_screen.dart';
import 'package:backend_project/views/resetpassword_screen.dart';
import 'package:backend_project/views/rootpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.red.shade50 ,
      body: Padding(
        padding: const EdgeInsets.only(top: 180, right:30 ,left: 30),
        child: Column(
          children: [

            Text("Karyana" ,style: GoogleFonts.montserrat(
              color: Color(0xffE31A21),
              fontSize: 40,
              fontWeight: FontWeight.w700
            ),textAlign: TextAlign.center,),

            SizedBox(height: 15,),
            Text("Sign In" ,style: TextStyle(
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

            SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 60,
                  color: Colors.white,
                child: TextField(
                  controller: passwordcontroller,

                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Resetpassword()));
                }, child: Text("Forgot password?",style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xffE31A21),

                ),
                ),
                ),
              ],
            ),

            SizedBox(height: 30,),

            isloading ? Center(child: CircularProgressIndicator(),):

            Container(
              width: 150,
              height: 50,
              child: ElevatedButton(onPressed: ()async{

                try{
                  isloading = true;
                  setState(() {

                  });
                  await authservices()
                      .loginuser(
                      email: emailcontroller.text,
                      password: passwordcontroller.text)
                      .then((value)async
                  {
                    UsersModel usermodel = await UserServices()
                        .getuserbyID(value!.uid.toString(),
                    );
                    userprovider.setuser(usermodel);

                    isloading = false;
                    setState(() {

                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RootPage(
                          userId: usermodel.docId!,  // <-- pass user id
                        ),
                      ),
                    );

                  });
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
               child: Text("login",style: GoogleFonts.poppins(
                 color: Color(0xffFFFFFF),
                 fontSize: 16,
                 fontWeight: FontWeight.w600
               ),)),
            ),

            SizedBox(height: 20,),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?",style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                    }, child: Text("Register",style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xffE31A21),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xffE31A21),
                    ),
                    ),
                    ),
                  ],
                )

              ],
            )


          ],
        ),
      ),

    );
  }
}
