import 'package:flutter/material.dart';

import 'package:food_shop/widgets/All_food.dart';
import 'package:food_shop/widgets/AppBarWidgets2.dart';
import 'package:food_shop/widgets/HomeAppBar.dart';
import 'package:food_shop/widgets/CategoriesWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List<dynamic>> fetchData() async {
    final response = await supabase.from('starbhak_mart').select('*');
    return response as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    // Ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // AppBar
          Appbarwidgets2(),

          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.01,
              left: screenWidth * 0.02,
            ),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Kategori
          Categorieswidget(),

          // All Food Section
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.01,
              left: screenWidth * 0.02,
            ),
            child: Text(
              "All food",
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Supabase
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  final List<dynamic> data = snapshot.data!;

                  // Responsif menggunakan GridView
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.01,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth < 600 ? 2 : 4, // 2 kolom untuk layar kecil, 4 untuk besar
                      crossAxisSpacing: screenWidth * 0.01,
                      mainAxisSpacing: screenHeight * 0.03,
                      childAspectRatio: 0.75, // Rasio lebar dan tinggi item
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/burger.jpeg',
                                  height: screenHeight * 0.10,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                item['name'] ?? 'No name',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rp. ${item['price'] ?? '0'}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Color.fromARGB(217, 227, 111, 10),
                                    size: screenWidth * 0.03,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
 