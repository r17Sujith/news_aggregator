import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twenty4_hours/CustomViews/CustomSortButton.dart';
import 'package:twenty4_hours/CustomViews/WebView.dart';
import 'package:twenty4_hours/Model/NewsResponse.dart';
import 'package:twenty4_hours/Provider/GaurdianNewsProvider.dart';
import 'package:twenty4_hours/Utils/ScreenUtility.dart';
import 'package:twenty4_hours/Utils/UtilityMethods.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key, required this.title,required this.isSearch});

  final String title;
  final bool isSearch;
  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  final ScrollController _controller = ScrollController();
  late String sortOption = "Newest";

  fetchData(bool isTabClick) {
     if(widget.isSearch){
      Provider.of<GuardianNewsProvider>(context, listen: false).getAllNews(sortOption,widget.title,widget.isSearch);
    }else{
      Provider.of<GuardianNewsProvider>(context, listen: false).getNewsSection(sortOption,widget.title,isTabClick);
    }
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData(false);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData(true);
    });
    super.initState();
    _controller.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Consumer<GuardianNewsProvider>(
          builder: (context, value, child) {
            if (widget.isSearch?value.page == 1 :value.sectionPage == 1) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(widget.isSearch?value.news.isEmpty:value.sectionNews.isEmpty){
              return const Center(
                child: Text("No content available"),
              );
            }
            return  CustomScrollViewer(controller: _controller, title: widget.title,value: widget.isSearch?value.news:value.sectionNews);
          }
        ),
      ),
      floatingActionButton: SortButton(
        currentSortOption: sortOption,
        onSortOptionSelected: (selectedOption) {
          // Handle the selected sort option here
          sortOption= selectedOption;
          fetchData(true);
          // Perform the sorting logic based on the selected option
        },
      ),
    );
  }
}

class CustomScrollViewer extends StatelessWidget {

  const CustomScrollViewer({
    super.key,
    required ScrollController controller,
    required List<Results> value,
    required String title
  }) : _controller = controller,_value=value,_title=title;

  final ScrollController _controller;
  final List<Results> _value;
  final String _title;


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
         SliverAppBar(
          floating: false,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(_title),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: _value.length,
        (context, index) {
          final news = _value[index];
          return InkWell(
            onTap: (){
              _processUserClick(news, context);
            },
            child: NewsCard(
              title: news.fields!.publication??"",
              description: news.webTitle!,
              imageUrl: news.fields!.thumbnail??"",
              date: news.webPublicationDate!,
            ),
          );
        }
        )),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: _value.length,
                (context, index) {
                  final news = _value[index];
              return InkWell(
                onTap: (){
                  _processUserClick(news, context);
                },
                  child: GridCard(title: news.fields!.publication??"", description: news.webTitle??"",));
            },
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.0,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: _value.length,
                    (context, index) {
                  final news = _value[index];
                  return InkWell(
                    onTap: (){
                      _processUserClick(news, context);
                    },
                    child: NewsCard(
                      title: news.fields!.publication??"",
                      description: news.webTitle!,
                      imageUrl: news.fields!.thumbnail??"",
                      date: news.webPublicationDate!,
                    ),
                  );
                }
            )),
      ],
    );
  }

  // Gets section name and stores for learning and reccomending
  void _processUserClick(Results news, BuildContext context) {
    UtilityMethods.storeNumOfClicksOnSections(news.sectionName!);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url: news.webUrl!),
      ),
    );
  }
}


class GridCard extends StatelessWidget {

  final String title;
  final String description;

  const GridCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.fade
              ),
            ),
            SizedBox(height: ScreenUtility.calculateHeight(height*8)),
            Text(
              description,
              maxLines: 4,
              style: const TextStyle(
                fontSize: 16,
                  overflow: TextOverflow.ellipsis
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  const NewsCard({super.key, required this.title, required this.description, required this.imageUrl, required this.date});

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery
            .of(context)
            .size
            .height - MediaQuery
            .of(context)
            .padding
            .top;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: ScreenUtility.calculateHeight(height*200),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ScreenUtility.calculateHeight(height*8)),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: ScreenUtility.calculateHeight(height*8)),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}











