
import 'package:flutter/material.dart';
import 'package:twenty4_hours/Screens/TabPage.dart';
import 'package:twenty4_hours/Utils/SharedPreference.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Icon actionIcon = const Icon(Icons.search);
  late Widget appBarTitle;
  @override
  void initState() {
    appBarTitle = Text(widget.title);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
               Expanded(
                flex: 20,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Topics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 80,
                child: ListView.builder(
                  itemCount: sharedPrefs.sectionList!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabPage(title: sharedPrefs.sectionList![index], isSearch: true)));
                      },
                      title: Text(sharedPrefs.sectionList![index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: appBarTitle,
          actions: [
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (actionIcon.icon == Icons.search) {
                    actionIcon = const Icon(Icons.close);
                    appBarTitle = TextField(
                      cursorColor: Colors.white,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabPage(title: value, isSearch: true)));
                      },
                      decoration: const InputDecoration(
                          prefixIcon:
                          Icon(Icons.search, color: Colors.white),
                          hintText: "search"),
                    );
                  } else {
                    actionIcon = const Icon(Icons.search);
                    appBarTitle = Text(widget.title);
                  }
                });
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: "Top news"),
              Tab(text: "Global"),
              Tab(text: "Business"),
              Tab(text: "Sport"),
              Tab(text: "Fashion"),
              Tab(text: "Food"),
              Tab(text: "Politics"),
              Tab(text: "Film"),
              Tab(text: "UK news"),
              Tab(text: "Media")
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabPage(title: "World",isSearch: false),
            TabPage(title: "Global",isSearch: false),
            TabPage(title: "Business",isSearch: false),
            TabPage(title: "Sport",isSearch: false),
            TabPage(title: "Fashion",isSearch: false),
            TabPage(title: "Food",isSearch: false),
            TabPage(title: "Politics",isSearch: false),
            TabPage(title: "Film",isSearch: false),
            TabPage(title: "UK-news",isSearch: false),
            TabPage(title: "Media",isSearch: false),
          ],
        ),
      ),
    );
  }
}
