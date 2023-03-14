import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsly_app/utils/snackbars.dart';
import 'package:provider/provider.dart';

import '../../view_models/saved_articles_view_model.dart';

class MainArticle extends StatelessWidget {
  const MainArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Article Detail',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color.fromARGB(75, 255, 255, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: CachedNetworkImage(
                  imageUrl: args.imgurl,
                  key: UniqueKey(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    child: Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      args.title,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      args.description,
                      maxLines: 9,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          args.tag,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 149, 149, 158),
                              fontSize: 14.0),
                        ),
                        Text(
                          args.date,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 149, 149, 158),
                              fontWeight: FontWeight.w300,
                              fontSize: 14.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Consumer<SavedArticlesViewModel>(
                  builder: (context, savedArticlesViewModel, child) {
                    return IconButton(
                        onPressed: () {
                          savedArticlesViewModel.addArticle(args);
                          openIconSnackBar(
                            context,
                            'Your Article Saved',
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.bookmark_add,
                          size: 40.0,
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
