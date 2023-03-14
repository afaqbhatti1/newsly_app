import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/models/news_model.dart';
import 'package:newsly_app/resources/widgets/searchbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsly_app/sevices/data_service.dart';
import 'package:newsly_app/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Icon(
            Icons.search,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
        automaticallyImplyLeading: false,
        title: searchTextField(search, context),
        elevation: 0.0,
      ),
      body: Consumer<HomeDisplayViewModel>(
        builder: (context, displayViewModel, child) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                height: MediaQuery.of(context).size.height * 0.33,
                child: StreamBuilder(
                  stream: displayViewModel.homeSlideDisplayList(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!(snapshot.hasData) ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List list = snapshot.data!.docs.map((e) {
                      debugPrint(e.id);
                      return NewsModel.fromJson(e.data());
                    }).toList();

                    return ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        NewsModel newsModel = list[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: CachedNetworkImage(
                                  height: 150,
                                  imageUrl: newsModel.imgurl,
                                  key: UniqueKey(),
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Container(
                                    color: Colors.black12,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const SizedBox(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 100,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newsModel.title,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.0),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          newsModel.tag,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 149, 149, 158),
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                          newsModel.date,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 149, 149, 158),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: displayViewModel.homeDisplayList(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!(snapshot.hasData) ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<NewsModel> list = snapshot.data!.docs.map((e) {
                        log(e.id);
                        return NewsModel.fromJson(e.data());
                      }).toList();

                      for (var element
                          in DataService.myUser!.followedCategories) {
                        element = element.toString();
                      }

                      List<String> myCategories = DataService
                          .myUser!.followedCategories
                          .map((e) => e.toLowerCase().toString())
                          .toList();

                      list.removeWhere((element) => !(myCategories
                          .contains(element.tag.toLowerCase().toString())));

                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          NewsModel newsModel = list[index];
                          if (search.text.isEmpty ||
                              newsModel.tag.toLowerCase().trim().startsWith(
                                  search.text.toLowerCase().trim())) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, mainArticle,
                                    arguments: newsModel);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: CachedNetworkImage(
                                      imageUrl: newsModel.imgurl,
                                      key: UniqueKey(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: Colors.black12,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const SizedBox(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 100,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                newsModel.title,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              newsModel.tag,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 149, 149, 158),
                                                  fontSize: 14.0),
                                            ),
                                            Text(
                                              newsModel.date,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 149, 149, 158),
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14.0),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
