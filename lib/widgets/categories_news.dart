import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_source_bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/style/theme.dart';
import 'package:news_app/screens/source_detail.dart';
import 'package:news_app/style/theme.dart' as mystyle;

class CategoriesNews extends StatefulWidget {
  @override
  _CategoriesNewsState createState() => _CategoriesNewsState();
}

class _CategoriesNewsState extends State<CategoriesNews> {
  List<CategoryModel> categoriesList = [
    CategoryModel(name: "business", icon: Icons.work),
    CategoryModel(name: "entertainment", icon: Icons.theater_comedy),
    CategoryModel(name: "general", icon: Icons.border_all),
    CategoryModel(name: "health", icon: Icons.healing),
    CategoryModel(name: "science", icon: Icons.science),
    CategoryModel(name: "sports", icon: Icons.sports_soccer),
    CategoryModel(name: "technology", icon: Icons.keyboard),
  ];
  @override
  void initState() {
    super.initState();
    // getSourcesBloc.getSources();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<SourceResponse>(
    //   stream: getSourcesBloc.subject.stream,
    //   builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
    //     if (snapshot.hasData) {
    //       if (snapshot.data.error != null && snapshot.data.error.length > 0) {
    //         return buildErorWidget(snapshot.data.error);
    //       }
    //       return _buildTopChannels(snapshot.data);
    //     } else if (snapshot.hasError) {
    //       return buildErorWidget(snapshot.error);
    //     } else {
    //       return buildLoadingWidget();
    //     }
    //   },
    // );
    return _buildCategories(categoriesList);
  }

  Widget _buildCategories(List<CategoryModel> categoriesList) {
    // List<SourceModel> sources = data.sources;
    // if (sources.length == 0) {
    //   return Container(
    //     width: MediaQuery.of(context).size.width,
    //     child: Column(
    //       children: [Text("No sources")],
    //     ),
    //   );
    // } else {
    return Container(
      height: 115.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            width: 80.0,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SourceDetail(source: sources[index])));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: mystyle.MyColors.mainColor,
                          blurRadius: 0.0,
                          spreadRadius: 3.0,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage("assets/logos/${sources[index].id}.png"),
                      // ),
                    ),
                    child: Icon(
                      categoriesList[index].icon,
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    categoriesList[index].name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  // SizedBox(height: 3.0),
                  // Text(
                  //   sources[index].category,
                  //   maxLines: 2,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: Colors.black54,
                  //     fontSize: 9.0,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
    // }
  }
}

class CategoryModel {
  final String name;
  final IconData icon;

  CategoryModel({this.icon, this.name});
}
