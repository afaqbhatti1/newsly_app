import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/models/news_model.dart';
import 'package:newsly_app/utils/snackbars.dart';
import 'package:newsly_app/view_models/saved_articles_view_model.dart';
import 'package:provider/provider.dart';

class SavedArticleWidget extends StatelessWidget {
  const SavedArticleWidget({super.key, required this.news});
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, mainArticle, arguments: news);
      },
      child: Slidable(
        key: const Key('0'),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Consumer<SavedArticlesViewModel>(
              builder: (context, value, child) {
                return SlidableAction(
                  onPressed: (context) {
                    value.removeArticle(news);
                    openIconSnackBar(
                      context,
                      'Deleted from saved',
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    );
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                );
              },
            )
          ],
        ),
        child: ListTile(
          leading: news.imgurl != 'image error'
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: news.imgurl,
                    key: UniqueKey(),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.black12,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black12,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : const Text('No image found!'),
          title: Text(
            news.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(news.tag),
              Text(news.date),
            ],
          ),
        ),
      ),
    );
  }
}
