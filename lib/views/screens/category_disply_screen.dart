import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsly_app/view_models/category_display_viewmodel.dart';
import 'package:provider/provider.dart';

class CategortDisplayScreen extends StatelessWidget {
  const CategortDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          '$args News',
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      body: Consumer<CategoryDisplayViewModel>(
        builder: (context, categoryViewModel, child) {
          return StreamBuilder(
            stream: categoryViewModel.categoryDisplay(args),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List list = snapshot.data!.docs.map((e) {
                return NewsModel.fromJson(e.data());
              }).toList();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    NewsModel newsModel = list[index];
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
