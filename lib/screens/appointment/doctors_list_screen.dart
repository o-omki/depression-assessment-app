import "package:flutter/material.dart";
import "package:serenity_space/widget/search_bar.dart" as customSearch;
import "package:serenity_space/widget/show_doctors.dart";

class DoctorsListScreen extends StatelessWidget {
  const DoctorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: const Material(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello User",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("images/doctor1.jpeg"),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                customSearch.SearchBar(),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Popular Doctors",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ShowDoctors(),
                
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}