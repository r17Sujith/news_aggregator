import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twenty4_hours/CustomViews/CustomConsumer.dart';
import 'package:twenty4_hours/CustomViews/CustomSortButton.dart';
import 'package:twenty4_hours/Provider/GaurdianNewsProvider.dart';


class TopPicksForUser extends StatefulWidget {
  const TopPicksForUser({super.key});

  @override
  _TopPicksForUserState createState() => _TopPicksForUserState();
}

class _TopPicksForUserState extends State<TopPicksForUser> {
  final ScrollController _controller = ScrollController();
  late String sortOption = "Newest";

  fetchData([bool? refresh]) {
    Provider.of<GuardianNewsProvider>(context, listen: false).getTopPicks(sortOption,refresh);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });
    super.initState();
    _controller.addListener(_scrollListener);
  }

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
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return RefreshIndicator(
      onRefresh: () async {
        await fetchData(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Picks'),
        ),
        body: ConsumerForFavoritesAndRecommendation(height: height, width: width,isFavorite: false,controller: _controller,),
        floatingActionButton: SortButton(
          currentSortOption: sortOption,
          onSortOptionSelected: (selectedOption) {
            // Handle the selected sort option here
            sortOption= selectedOption;
            fetchData(true);
            // Perform the sorting logic based on the selected option
          },
        ),
      ),
    );
  }
}