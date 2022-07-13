import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: AppBar(
        title: Text("Product",
            style: headerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: lightModeBgColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          tooltip: 'Kembali ke halaman product',
          onPressed: () {
            // handle the press
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: widthDevice -32,
                      child: TextFormField(
                          
                          decoration: InputDecoration(
                                 prefixIcon:  Icon(Icons.search,color: neutral60,),
                    
                          fillColor:
                            neutral20,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: neutral20, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: neutral20, width: 1.5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide:
                                BorderSide(color: Color(0xffEDEDED), width: 1.5),
                          ),
                          focusColor: Colors.red,
                          labelStyle: TextStyle(color: primaryColor),
                          hintText: "Cari apa ?",
                    
                          contentPadding: EdgeInsets.all(18), // Added this
                        ),
                      ),
                    ),
                
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.only(top: 20),
                 
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                                                    margin: EdgeInsets.only(right: 10),

                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70, 
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              height: 70, 
                               decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                    color: Color(0xffEAF3DE),
                              ),
                                                                        

                              child: Image.asset('assets/images/category_1.png',width: 20,height: 20),
                            ),
                            SizedBox(height: 5,),
                            Text("Vegetable",style: subtitleTextStyle.copyWith(fontSize: 13))
                          ],
                        ),
                      ),
                      Container(
                                                    margin: EdgeInsets.only(right: 10),

                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70, 
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              height: 70, 
                               decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xffFFDBDB),
                              ),
                                                                        

                              child: Image.asset('assets/images/category_2.png',width: 20,height: 20),
                            ),
                            SizedBox(height: 5,),
                            Text("Daging",style: subtitleTextStyle.copyWith(fontSize: 13))
                          ],
                        ),
                      ),
                    
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
