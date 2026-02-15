import 'package:backend_project/views/product/favorite_products.dart';
import 'package:backend_project/views/product/getall_product.dart';
import 'package:backend_project/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category/getall_category.dart';
import 'home_screen.dart';

class RootPage extends StatefulWidget {
  final String userId;

  const RootPage({super.key, required this.userId});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  // Pages list
  @override
  void initState() {
    super.initState();

    _pages = [
      HomeScreen(userId: widget.userId),
      FavoriteProducts(userId: widget.userId),
      GetallCategory(),
      GetallProduct(),
      Profile(userId: widget.userId),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  // show the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red.shade50,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xffE31A21),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorite",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Category",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined),
            label: "Products",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
