import 'package:backend_project/provider/user_provider.dart';
import 'package:backend_project/views/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final String userId;
  const Profile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getuser();

    return Scaffold(
      backgroundColor: Colors.white ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // App Title
            Text(
              "Karyana",
              style: GoogleFonts.montserrat(
                color: const Color(0xffE31A21),
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Profile Page",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),

            // Profile image
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/profile picture1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Name
            Text(
              user.name ?? "Unknown Name",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),


            SizedBox(height: 5,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
            },
                child: Text("Edit Profile",style: GoogleFonts.poppins(
                    color: Color(0xffE31A21),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xffE31A21)
                ),
            )),

            const SizedBox(height: 20),

            // Icons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, color: Colors.red.shade600, size: 30),
                const SizedBox(width: 20),
                Icon(Icons.email, color: Colors.red.shade600, size: 30),
                const SizedBox(width: 20),
                Icon(Icons.calendar_today,
                    color: Colors.red.shade600, size: 30),
              ],
            ),

            const SizedBox(height: 30),

            // Info Card
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Email:", user.email ?? "N/A"),
                  _infoRow("Phone:", user.phone?.toString() ?? "N/A"),
                  _infoRow("Address:", user.address ?? "N/A"),
                  _infoRow("Created At:",
                    user.createdAt != null
                        ? DateTime.fromMillisecondsSinceEpoch(user.createdAt!)
                        .toString()
                        : "N/A",
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.cake, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      Text(
                        "User Since: ${user.createdAt != null ?
                        DateTime.fromMillisecondsSinceEpoch(user.createdAt!)
                            .year : "N/A"}",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),


            Container(
              width: 150,
              height: 50,
              child: ElevatedButton(onPressed: (){

              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )

                  ),
                  child: Text("Logout",style: GoogleFonts.poppins(
                  color: Color(0xffFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              )
                  )),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
