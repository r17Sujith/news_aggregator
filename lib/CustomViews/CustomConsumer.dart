import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twenty4_hours/CustomViews/WebView.dart';
import 'package:twenty4_hours/Provider/GaurdianNewsProvider.dart';
import 'package:twenty4_hours/Utils/ScreenUtility.dart';
import 'package:twenty4_hours/Utils/UtilityMethods.dart';

class ConsumerForFavoritesAndRecommendation extends StatelessWidget {
  const ConsumerForFavoritesAndRecommendation({
    super.key,
    required this.height,
    required this.width,
    required this.isFavorite,
    required this.controller,
  });

  final double height;
  final double width;
  final bool isFavorite;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Consumer<GuardianNewsProvider>(
        builder: (context, provider, _) {
          final articles = isFavorite?provider.favoriteSection:provider.topPicksSection;
          if (isFavorite?provider.favoritePage ==1:provider.topPicksPage==1) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            controller: controller,
            itemCount: provider.isFavoriteLoading||provider.isTopPicksLoading?articles.length+1:articles.length,
            itemBuilder: (context, index) {
              if(index<articles.length) {
                final article = articles[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      UtilityMethods.storeNumOfClicksOnSections(
                          article.sectionName!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewPage(url: article.webUrl!),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(article.fields!.thumbnail != null)
                            Image.network(
                              article.fields!.thumbnail ?? "",
                              height: ScreenUtility.calculateHeight(
                                  height * 120),
                              width: ScreenUtility.calculateWidth(width * 80),
                              fit: BoxFit.cover,
                            ),
                          SizedBox(
                              width: ScreenUtility.calculateWidth(width * 16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.fields!.publication ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: ScreenUtility.calculateHeight(
                                    height * 8)),
                                Text(
                                  article.webTitle ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: ScreenUtility.calculateHeight(
                                    height * 8)),
                                Text(
                                  article.webPublicationDate ?? "",
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }
}